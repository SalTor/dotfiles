---
name: deck-signals
description: How to answer a chat deck started from a signal row. Use when the prompt opens "deck's <rule> signal fired on topic ..." or names one of unmeasured-goal, stale-spec, status-mismatch, cross-repo-contract, spawned-work, stuck-unit, big-then-small, gate-cleared, or when the message carries deck vocabulary such as topic, unit, coupling, gate, spawned topic, or a forge ref like gh:Fast-Growing-Trees-LLC/redwood/pr/2451.
---

# Answering a deck signal

deck is Sal's cross-repo rollup. A signal is one rule firing over one project's
model. Clicking the chat icon on a signal row opens this chat with the rule, the
scope and the evidence in the composer and nothing else:

```text
deck's stuck-unit signal fired on topic "Klaviyo _kx to ad pixels":

gh:Fast-Growing-Trees-LLC/redwood/pr/2451 open since 2026-08-19, last activity 2026-08-28 (19d)
```

deck said what it saw. It did not decide what to do, and neither has anyone else.

## Before the first move

```text
where am I     one repo of the project (redwood, grove, etl-pipelines, deck)
what I can do  read code and specs in this repo, read any forge, write this repo,
               add a line to the project file with `deck project`
what I cannot  edit another repo, hand-edit ~/.deck/projects/*.md
forge refs     gh:owner/repo/pr/N  -> gh pr view N --repo owner/repo
               gl:group/proj/mr/N  -> glab mr view N --repo group/proj
```

`gh` and `glab` are the same CLIs deck itself shells out to, already
authenticated. Use them for anything the evidence points at.

Four standing rules:

1. **One repo, many repos.** A coupling or a gate spans two or three repos. Do
   in this repo what belongs here, read the others through the forge, and report
   what needs doing elsewhere instead of trying it. Name the repo and the change.
2. **`~/.deck/projects/*.md` is Sal's, and deck appends to it for you.**
   Decision 025 changed this rule. Do not open the file in an editor: it is
   hand-formatted, and the commands below splice one line in and leave the prose,
   the comments and the alignment exactly as they were.

   ```bash
   deck project topic <slug> "spec:20260918-xxxx" "The title"
   deck project repo <slug> <gh|gl> <owner/repo> [--name n] [--specs dir] [--local dir]
   deck project metric <slug> <metric-slug>
   ```

   They append and never remove, so a line already there is a refusal and not an
   overwrite. If deck answers "the project file changed on disk", he saved it
   while you were working: nothing was written, so read it again and re-run.

   Three things still have no command, so for those print the exact line and let
   him paste it: `test:` on a coupling, `signals_off:`, and `extra_units:`.

   A number never goes in this file. A measurement is a wiki evidence run
   (`deck-metrics` skill).
3. **Specs and code in this repo are fair game.** A topic's spec lives in the
   repo, not in the project file. Editing it is normal work.
4. **A signal can be wrong or stale.** Rollups run against a moment. Saying "the
   spec was updated yesterday, this fired on a cached model" with the evidence is
   a correct answer and better than inventing work. Repeated false firing is
   grounds for proposing `signals_off: [rule]` to Sal.

## The eight rules

Find your rule, read the test, then the move.

```text
rule                  deck's actual test                                      first move
unmeasured-goal       metric named, newest measurement >14d old, units        measure it
                      landed since it
stale-spec            spec lastUpdated >7d older than newest landed unit      update the spec
status-mismatch       spec status disagrees with the units                    fix whichever is lying
cross-repo-contract   a coupling has test: none or empty                      write the test
spawned-work          kind: spawned topic has open or planned units           spec it or say why not
stuck-unit            open unit, no forge activity in 10d                     find the blocker
big-then-small        first 3 of >=5 landed units carry >=60% of added lines  confirm, usually no action
gate-cleared          unit's body links a unit in another repo that merged    act on what is unblocked
                      >=2d after this one opened and before it landed
```

### unmeasured-goal

Project-level, no topic. The measurement clock is the newest of three things,
in this order: a reading filed against a metric the project references, the
project's `baseline.measured`, and every `measured YYYY-MM-DD` in the topics'
spec files. "never" means none of them exists.

```bash
deck metrics                  # is the question already asked?
deck metric show <slug>       # how it was measured last time, and the query
```

A reading holds the query it came from, so the last one is the instruction for
taking the next. If the project references no metric yet, the spec carrying the
newest `measured` line usually holds the query instead.

Re-run it. The `query-db` skill is the route to Redshift and MySQL. Then file
the answer as a wiki evidence run per the `deck-metrics` skill; never run
`deck metric new` or `deck metric record`.

Do not give Sal a `baseline:` line to paste. Good answer: one number, its date,
the query that produced it, and the path of the evidence run.

### stale-spec

The spec is behind the code by more than a week and the evidence says how many
units landed since. Read those units' diffs, then bring the spec's status table,
acceptance criteria and open questions up to what actually shipped. Bump
`lastUpdated`. Do not invent decisions the code did not make. Where a unit
contradicts the spec's plan, record the contradiction in the spec. Do not edit
the plan until it matches.

### status-mismatch

Three different faults behind one name:

```text
spec status Discovery|Planned, N units landed   the spec never got promoted
spec status In Progress, nothing open, quiet    the work stopped or finished
spec status Done, N open and M planned          Done was premature, or the open units are unrelated
```

Decide which side is wrong. Usually the status. For the quiet case, check whether
the landed units satisfy the acceptance criteria: if they do, it is Done; if they
do not, it is parked and the spec should say what is left and why it stopped.
That third case is often a mis-tagged unit, so check the tags before moving
status.

### cross-repo-contract

Not inferred. The coupling is written in the project file and it says `test:
none`. Example shape: a cache key version in redwood against a hasher recipe in
grove, or one dependency pin held in two repos.

```text
1  read both sides, through the forge for the repo you are not in
2  find the side that can fail loudly and cheaply, usually the consumer
3  write that test here if this is that repo
4  if the test belongs in the other repo, say so and give the test
5  print the project-file line for Sal, since `test:` on a coupling has no
   command yet:  test: apps/consumer-api/test/identity_hasher_contract.test.ts
```

A drift check that reads both values and compares them beats a unit test that
restates one of them.

### spawned-work

The topic is `kind: spawned`, matched by branch glob rather than by a tag, and it
has live units. deck is saying real work has no paperwork behind it. No forge
refs in the evidence, because the rule is precisely about untagged work.

Find the units with the glob (`gh pr list --search`, or the local jj bookmarks),
read them, then answer one question: does this deserve a spec of its own?

```text
yes   write the spec in this repo's spec dir, then add the topic yourself:
        deck project topic <slug> "spec:20260916-xxxx" "The title"
      The spawned topic stays until Sal drops it; two lines for one strand is
      his to resolve, and saying so is part of the answer.
no    say why in one line (a dependency bump, a revert, a one-file fix) and
      leave it a spawned topic
```

Both answers are complete. Writing a ceremonial spec for a pin bump is worse
than saying it does not need one.

### stuck-unit

An open PR or MR with no forge activity in ten days. Three or more in one topic
collapse into one line with the range and the first and last ref, so a whole
stack may be behind a single row.

```bash
gh pr view 2451 --repo Fast-Growing-Trees-LLC/redwood --json title,body,state,isDraft,reviewDecision,statusCheckRollup,comments
```

Diagnose before touching anything. The usual causes and what each needs:

```text
red CI                  fix it here if the repo is this one
waiting on review       name the reviewer, ask Sal to nudge
waiting on another PR   check if that one landed; this may be gate-cleared now
draft, work unfinished  say what is left
superseded or dead      recommend closing, with the thing that replaced it
```

Do not push to someone else's branch. Do not reopen, close or comment on a PR
without being asked.

### big-then-small

An observation about sequencing, not a defect. The first three landings of the
topic carried most of the lines. Normally that is scaffolding first and
refinements after, which is healthy.

Look once for the failure mode: the big early units landed under an unreviewed
rush, or the small later ones are repeated patches to one weak piece. If neither,
say so and stop. "Confirmed, the first units were the schema and the endpoint,
the rest are follow-ups. Nothing to do." is usually the right answer.

### gate-cleared

Good news. This unit's body linked a unit in another repo, that one merged at
least two days after this one opened and no later than this one landed, and deck
excluded the case where both link each other and land together. So this unit was
held on the other one, and the other one is in.

```text
1  confirm the gate merged                   forge view on the other ref
2  check this unit's state                   still open? the hold is gone, it can move
3  if it already landed, look forward         what else was waiting behind the same gate
4  report the unblocked thing by name
```

If this unit is still open, the actionable item is whatever it needs now
(rebase, re-request review, flip out of draft) in this repo. If the gate was a
version bump or a flag in another repo, verify the deployed side really carries
it before calling it clear.

## Shape of a good response

```text
what deck saw        one line, restated
what is true now     what the forge and the code actually say
what I did           edits in this repo with paths, any `deck project` command
                     you ran with its output, and any evidence run filed, with its path
what Sal must do     work in another repo, or the three project-file keys that
                     still have no command
```

If the honest answer is that the signal is stale, that is the whole response.
