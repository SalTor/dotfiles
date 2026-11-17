---
name: review
description: Review a Jujutsu revset from a staff-engineering perspective by fanning the review out to multiple focused subagents (one per review lens) plus a generalist, having the lenses cross-examine each other's findings, then merging what survives
---

# review - Revset Review (multi-lens subagent fan-out)

Review a Jujutsu revset and produce a staff-engineering review. **The actual reviewing is always performed by subagents, and always by more than one.** The top-level agent resolves the target, picks the review lenses, dispatches one subagent per lens, then merges and relays their findings.

## Usage

```text
/review [revset]
```

Examples:
- `/review` → defaults to `trunk()..@`
- `/review @`
- `/review @-`
- `/review nwr`
- `/review trunk()..feature-bookmark`

If no revset is given, default to `trunk()..@`.

## Why multiple subagents

A single reviewer's attention is shaped by whatever it noticed first. Once an agent locks onto the data-flow question in a diff, it reads the rest of the diff through that question and stops seeing the deploy-compatibility break or the test that asserts nothing. Splitting the work by lens means each agent arrives with one question and no competing priorities, so the things a generalist skims past get found. The generalist still runs, because narrow lenses miss whatever falls between them.

Other reasons the review is delegated at all:

- **Independence** - a fresh subagent judges the diff on its own merits, unbiased by the reasoning, assumptions, or mistakes that produced the code earlier in this conversation.
- **Context hygiene** - reading full diffs and PR threads is token-heavy; keeping it in subagents leaves the main context uncluttered.

## Why cross-examine

A lens that finds a defect is the worst judge of it: it already believes the finding, and it has read the code through the question that produced it. Another lens reads the same code through a different question, so it can see where the finding's premise breaks, and where the finding points at something larger that its author stopped short of. Cross-examination puts every serious finding in front of a lens that did not raise it, before anything reaches the report.

## Workflow

The top-level agent does steps 1-4, the routing in step 6, and steps 7-8. It does **not** read diffs or form findings itself.

### 1. Resolve the target revset

- If the user gives a revset, use it verbatim. Otherwise default to `trunk()..@`.
- Validate it resolves to at least one change:
  ```bash
  jj log -r '<revset>'
  ```
- If empty or invalid, report that and stop. Don't dispatch subagents for nothing.

### 2. Enumerate the stack and survey the diff shape

- List change IDs, oldest first:
  ```bash
  jj log -r '<revset>' --no-graph -T 'change_id.short() ++ "\n"'
  ```
- Get the shape of the change without reading it. File paths and line counts are enough to pick lenses:
  ```bash
  jj diff -r '<revset>' --stat
  jj log -r '<revset>' --no-graph -T 'description ++ "\n"'
  ```
- Read only the stat and the descriptions here. Resist opening the diff itself; that is the subagents' job.

### 3. Gather shared context once

Fetch what every lens would otherwise fetch separately, and write it to a temp file the subagents read.

- Existing PR/MR feedback, so no lens relitigates settled discussion. Detect the forge from `jj git remote list` (fall back to `git remote get-url origin` only if `jj` is unavailable).
  - **GitHub** (`gh`), from the bookmark's branch or with an explicit `<number>`:
    ```bash
    gh pr view [<number>] --json number,url,title,state,body,reviews,reviewThreads,comments
    gh api repos/{owner}/{repo}/pulls/{number}/comments
    ```
  - **GitLab** (`glab`):
    ```bash
    glab mr view [<iid>] --comments
    ```
- The project's reviewer checklist, if there is one: a **`REVIEW.md`** at the repo root. Note its path for the subagents rather than reading it yourself.
- Related work on the wiki's board, so no lens reviews the diff blind to what teammates are building or just rebuilt. Run this when `command -v friday` succeeds and the repo's name (the last segment of its remote URL, without `.git`) is a key of `repos` in the vault's `.friday/config.json`:
  ```bash
  jj diff -r '<revset>' --name-only | friday domains --repo <name> --paths -
  doms=$(jj diff -r '<revset>' --name-only | friday domains --repo <name> --paths - --names)
  [ -n "$doms" ] && friday list --domain "$doms" --recent 30d
  ```
  The first prints the domains the diff hits and the wiki pages to read (paths under the vault root it names); the third prints the open issues in those domains and those finished in the last 30 days, with assignee and title. Copy both outputs into the scratch file under a `## Related work` heading. Do not read the pages or the issues yourself; that is the Related work lens's job. If `friday` is missing, the repo has no domains, or the lookup returns nothing, write that under the heading and do not pick the lens.
- Write the PR body and the comment threads to a scratch file (`mktemp`), and pass that path to every subagent. If no PR/MR exists (pre-push or local-only stack), say so and skip the PR part; the related-work section still goes in.

### 4. Pick the review lenses

Choose **3 to 6 lenses** for this diff. One is always the generalist. Pick the rest from the catalog below by matching the diff's actual shape from step 2, and don't pick a lens whose trigger the diff doesn't hit. Six focused agents on a two-line change is waste; three on a 40-file stack is a miss.

Sizing guide: single small change → generalist + 2. Multi-file feature → generalist + 3 or 4. Large or cross-cutting stack → generalist + 5, or fan out per change ID with a smaller lens set each.

**Lens catalog** (trigger → lens):

| Lens | Pick it when |
| --- | --- |
| **Generalist staff engineer** | Always. Reviews the whole diff with no assigned focus, including whatever the other lenses don't cover. |
| **Correctness and edge cases** | Any non-trivial logic: branching, null/empty/boundary handling, state transitions, data flow between layers. |
| **Failure modes and resilience** | Network or third-party calls, error handling, retries, timeouts, caching, fallbacks, anything that can partially fail. |
| **Deploy safety and contracts** | Route add/remove/rename, loader or action JSON shape changes, GraphQL query or fragment edits, generated types, shared exported symbols, API payload changes. |
| **Shared-symbol callsite sweep** | A component prop, function signature, exported type, or render-prop shape changed. This lens's job is to enumerate every *usage* with line-level search (not `grep -l`) and verify each one by hand, since a callsite that ignores the changed field still type-checks. |
| **Security and privacy** | Auth, secrets, PII, request/header capture, error reporting scope, user input reaching a query or a URL, third-party pixels. |
| **Performance and scale** | Loops over network calls, per-request or per-session caching, fan-out, large payloads, list rendering, query patterns. |
| **Test quality** | Tests added or changed, or production code changed that existing tests cover. It hunts tests that cannot go red on the bug they name. Pass the path of [`test-quality.md`](test-quality.md) (beside this file) in the lens prompt, and tell the lens to read it first: it holds the scope, the finding labels, the evidence bar and the severities. |
| **Intent and scope conformance** | There is a spec, PR body, or commit description to check the diff against. Does the code do what it claims, and only that? It also reads the PR/MR body and the commit descriptions for references the forge will link to the wrong place. On GitHub a bare `#N` links to issue or PR N of this repo, so `React error #421`, `step #2`, or another repo's PR number gets a link to an unrelated PR. GitLab does the same with `#N` for issues and `!N` for MRs. Each finding (`nit`) quotes the text, names the PR or issue it will link to, and gives the fix: a full URL or `owner/repo#N` for another repo, a link to the real target (`[React error #421](https://react.dev/errors/421)`) or a code span for anything else. |
| **Simplification and altitude** | Reasonable on most diffs: reuse of existing helpers, duplication, wrong layer, dead code, over-abstraction. |
| **Domain conventions** | The diff touches a domain with its own authoring doc (UI/design, analytics, experiments, error capture, money math). Pick this lens once per domain doc the diff actually touches, and name that doc in the lens prompt. |
| **Related work** | Step 3's lookup found pages or issues. Always pick it then. It reads every listed page, scans the issue titles, and runs `friday show <id>` on the few that touch what the diff changes. It reports where the diff works against that work: it reimplements or sidesteps something a recent refactor centralized (a new field or helper answering a question a canonical function already answers), conflicts with an in-progress change in the same area, contradicts a rule a page states, or duplicates planned work. Calling the canonical function is not enough: check that every value the diff derives in that area comes from the function's answer, and treat a field that splits off part of that answer, or recomputes part of it with an older rule beside it, as a finding or a question. A page or issue that describes this diff's own work (it names the PR, its spec, or its issue) states the author's intent; it is not a rule to check the diff against. Each finding names the issue or page, its owner (the assignee), and the diff line, and quotes the page or issue text it relies on. When the conflict is a direction question rather than a demonstrable failure, it goes under Questions for the author, addressed so the author knows whom to ask ("CT-411 (Andrew) moved restriction into `resolveAvailability`; should this field come from it?"). |
| **Docs and prose** | The diff is mostly documentation, ADRs, or specs. Review framing, sequencing, and evidence quality. For a `proposed` ADR that defers scoping to follow-up specs, stay at proposal granularity. |

Tell the user which lenses you picked, in one line, before dispatching.

### 5. Dispatch all lenses at once

- Use the `Agent` tool, subagent type `general-purpose` (or a dedicated code-review agent if one is configured).
- **Issue every lens agent in a single message so they run concurrently.**
- Each lens agent gets the same base prompt plus its own focus. The base prompt must include:
  - The resolved revset and the change IDs from step 2.
  - Instructions to read the full diff for each change (`jj show <change-id>`), not filenames or descriptions alone, and to cite **Jujutsu change IDs**, never git commit hashes.
  - The scratch-file path from step 3, with instructions to read it first and to skip anything already raised by a human reviewer, **including in resolved threads**. If the lens would reinforce or push back on an existing thread, it names the thread ("agree with X's comment on `<file>:<line>`") rather than restating it as a fresh finding.
  - The `REVIEW.md` path if one exists, to be applied as the project's authoritative checklist, citing the relevant section (for example "§2.4") in any finding it drives.
  - The evidence bar, verbatim: **a finding needs a concrete failure it causes.** Name the input, state, or sequence that triggers it and what goes wrong. If it can't be demonstrated from the diff and the surrounding code, drop it. "Could be a problem" is not a finding.
  - Permission to return nothing. An empty findings list from a lens is a real, useful result. Never pad to look thorough.
  - No praise. Do not report what the change does well; report only findings, questions, and coverage.
  - The return format below.
- Each lens agent returns, as its final message:
  - **Findings** - each with severity (`blocker` / `major` / `minor` / `nit`), change ID, `file:line`, the concrete failure, and a one-line confidence note ("verified by reading X" vs "inferred from the diff").
  - **Questions for the author** - hidden assumptions, unclear intent, missing context. Kept separate from findings and unclassified by severity.
  - **Coverage note** - what the lens looked at, and anything it left to another lens.
- While the subagents run, do not start reviewing the diff yourself.

### 6. Cross-examine the findings

Run one round of cross-examination. Each lens examines findings that other lenses raised. Skip this step only if no lens returned a finding above `nit`.

**Route.** The top-level agent does this from the returned reports, without reading the diff:

1. Collapse findings that several lenses raised about the same defect into one entry, and number every entry (`F1`, `F2`, ...). Record which lenses raised each one.
2. Leave `nit` findings out of the round.
3. Assign each remaining finding to an examiner lens that did not raise it. Pick the lens whose question is most likely to break the finding's premise. For example, send a correctness finding to the failure-modes or generalist lens, and send a performance finding to the correctness lens. Assign each `blocker` and `major` to two examiners. Assign each `minor` to one.
4. Spread the work so no lens examines far more than the others.

**Dispatch.** Send each lens its batch in a single message so they run concurrently. Continue each lens agent with `SendMessage`, because it has already read the diff. If a lens agent cannot be continued, start a fresh `general-purpose` agent with that lens's focus, the base prompt from step 5, and the batch. The examiner prompt must include:

- Each finding in the batch, verbatim, with its ID, the lenses that raised it, and its confidence note.
- The instruction to **refute** each finding. Read the code the finding cites and the code around it. Argue that the finding is wrong, overstated, or already handled elsewhere. Do not judge whether the finding is plausible. Try to break it.
- The same evidence bar as step 5, applied to the refutation. A refutation must cite code that the examiner read. "This is probably handled" does not refute a finding.
- The instruction to report what each finding implies beyond itself. Ask whether the finding is a symptom of a larger design problem, and whether the same defect appears at other sites. Report these as new findings that meet the step 5 evidence bar. Do not repeat the original finding.
- The return format below.

Each examiner returns, as its final message:

- **Verdicts** - one per finding ID: `upheld`, `downgraded` (with the new severity), or `refuted`. Each verdict includes a reason and the `file:line` the examiner read to reach it.
- **New findings** - in the step 5 format, each tagged with the finding ID that led to it.

**Apply the verdicts.**

- `upheld` by every examiner: keep the finding at its severity.
- `refuted` by every examiner, with cited code: drop it. A refutation based only on inference does not drop a finding whose original lens cites code it read. Turn that pair into a question for the author.
- `downgraded`: use the lowest severity that an examiner supported with cited code.
- Two examiners disagree: keep the finding at the lower severity, mark it `contested` in the report, and state each examiner's reason in one line.
- New findings from examiners go to step 7 without another round. Mark each one "raised in cross-examination of F<n>".

Do not run a second round. If a new finding is a `blocker`, say in the report that it was not cross-examined.

### 7. Merge the findings

- **Start from the cross-examined set.** Use the findings and severities that came out of step 6, not the raw lens reports.
- **Dedupe.** Several lenses will land on the same defect from different angles, and examiners' new findings can repeat each other. Merge them into one finding and keep the clearest statement of the failure. Note when a defect was found independently by more than one lens; that is a strong signal, not a duplicate to be halved.
- **Keep single-lens findings.** A finding only one lens saw is the entire point of the fan-out. Judge it on its evidence, not on its vote count.
- **Apply the bar again at merge time.** Drop findings with no demonstrable impact, lint-style observations, and conventions the project doesn't actually enforce. Prefer fewer, higher-signal findings over a long list.
- **Rank by severity, then by impact within severity.**
- Resolve disagreement between lenses explicitly rather than reporting both sides. If two lenses contradict each other on the same code, say which reading holds and why, or turn it into a question for the author. The exception is a finding that step 6 marked `contested`. Report it with both reasons.

### 8. Relay the report

Present a single merged review, not a pile of per-lens reports:

- Header: revset reviewed, change count, PR/MR link if any, lenses run, cross-examination tally (examined, upheld, downgraded, refuted, new), overall recommendation (`approve`, `approve with follow-ups`, or `changes required`).
- Findings grouped by severity, each tied to a change ID and `file:line`. Lead with blockers and caveats.
- No praise. Do not add positive callouts, even if a caller's instructions offer a praise label; leave that label unused.
- Questions section.
- Unresolved existing review threads that block approval.
- If nothing survived the merge, say so explicitly, and name the lenses that ran so "no findings" reads as coverage rather than silence.

Don't silently rewrite a subagent's finding into something it didn't say. Sharpening the wording is fine; changing the claim is not.

## Notes

- The review is **always** delegated, and always to more than one subagent. Never produce the review inline, regardless of how small the diff looks.
- Git is a fallback only if `jj` is unavailable in this repo.
- For *fix-it* output (apply changes, not just report them), use `/simplify` instead.
