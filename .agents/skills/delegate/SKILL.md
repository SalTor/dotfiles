---
name: delegate
description: How to fire off a sub-agent - deciding whether the work is worth delegating, which model does which part (Opus 5.5 specs by default and Fable 5.1 for the hard ones, Opus 5.5 builds, Sonnet 5 small fixes and research), keeping usage down, giving each agent its own jj workspace when the work is in a repo, writing a brief it can act on without guessing, and what it must report back so the delegator can verify and relay. Use when spawning implementation or research agents, running several at once, or when a sub-agent has landed and its work needs checking before anything is pushed.
disable-model-invocation: true
---

# Firing off a sub-agent

You are the one talking to Sal. A sub-agent is not: its output goes to you and
nobody else, so everything it produces has to be verifiable by you and relayable
by you. That single fact decides how to brief it and what to ask back.

## Is it worth delegating

Delegation buys two things and costs one. It buys parallelism, and it buys a
reader with no stake in the reasoning that produced the code so far. It costs a
context transfer: everything the agent needs to know that it cannot read off
disk, you have to write down.

```text
travels well                        stays with you
separable scope, few shared files   needs the argument you had three turns ago
a stated verification gate          the gate is "does this feel right"
reading wide, reporting narrow      three minutes of editing
a lens someone fresh should apply   a decision Sal has not made yet
```

The test is whether you can write a brief the agent can act on without guessing.
If writing the brief is most of the work, do the work. If you cannot name the
command that proves it worked, delegating produces a claim rather than a result,
and you will end up doing it again to check.

## Which model does which part

Spec first, then build, and each half has its own model. Pass it as the
`Agent` tool's `model`, since the default inherits yours.

```text
speccing, planning, design        one Opus 5.5 agent     model: "opus"
  ...when the problem deserves it one Fable 5.1 agent    model: "fable"
implementation                    Opus 5.5 agent(s)      model: "opus"
a fix touching one to three files Sonnet 5 agent         model: "sonnet"
read-only research, no code       Sonnet 5 agent         model: "sonnet"
```

The spec model is your call, made per problem without asking Sal. Opus is
the default. Pick Fable when the problem itself is hard, not when the spec
is long:

```text
Opus 5.5                              Fable 5.1
follows a pattern the repo has        no precedent in the repo to follow
one subsystem, scope already known    several subsystems, or a contract between
                                        services or repos
the cause is measured, the fix shape  the right shape is unclear and the options
  is mostly obvious                     trade off against each other
easy to undo                          a record format, protocol or wire shape
                                        that is costly to change once written
```

When you are unsure, use Opus. Its spec shows whether the problem is harder
than it looked, and a fresh Fable agent can start from that committed spec.
Tell Sal which model you picked, and for Fable, why.

Before the spec agent starts, ask Sal the two to four questions that
decide the design, in one batch (below). Put his answers in its brief. It
writes the spec (and the decision, where the repo keeps them) and commits
it, with no code, and defaults every remaining question without asking,
listing each default in the spec so Sal can overturn it later. Keep the
spec near 250 lines with at most five open questions. The Opus agents
build from that committed spec, one workspace each, and the brief points
them at it by path rather than restating it. Read the spec before firing
the builders.

Avoid resuming a spec agent to revise its spec. A resumed agent re-reads
its whole context, and revisions were about 40% of Fable use on
2026-09-30. Make a small revision yourself. When a revision is larger,
start a fresh agent with the committed spec and the change.

A task too small to need a spec (a fix in one to three files, a test that
flakes, a stale doc) goes straight to a Sonnet agent, or to Opus when the
fix needs real design judgment. Research or a read-only question that
produces no code goes to Sonnet.

Sal, 2026-09-30: "a fable 5.1 subagent should be used for speccing/planning
and then opus 5.5 subagent(s) should be used for implementation". Revised
2026-10-01 after hitting the five-hour usage limit: Sonnet for small fixes
and research, the question and spec caps above, and the limits below.
Revised 2026-10-02: Opus specs by default, and the delegator decides per
problem whether it deserves Fable.

## Keeping usage down

```text
questions     ask in batches of four, one topic each, not one per turn
builders      at most two running at once
orchestrator  start a fresh session after each batch of landings, with a
              short handoff, rather than carrying every landing's context
```

## A workspace per agent

In a repo, every sub-agent that writes gets its own jj workspace. Several agents
editing one working copy corrupt each other: a snapshot taken mid-write commits
another agent's half-file, and one agent's broken file fails the other's tests
for reasons neither can see. jj's own answer to this is a workspace, one working
copy per worker over one shared repo and one op log.

```bash
jj workspace add --name <slug> ~/code/workspaces/<repo>/<slug>
jj workspace list        # who else is attached, and where
```

Prefer the Claude Code worktree flow (`EnterWorktree`, or the `Agent` tool's
`isolation: "worktree"`). The jujutsu plugin's hooks route it to
`jj workspace add` and place it at the central path, and they copy the
gitignored config that `.worktreeinclude` lists. Read the `jj-workspaces` skill
before creating one by hand, since the path convention is the layout setting's
business and not yours to pick.

From a deck chat, the worktree flow fails: the chat folder is not a jj
repo, so the hook refuses. Make the workspace with
`deck chat workspace add <main checkout> <slug>`, which runs the repo's
bootstrap hooks and records it, and hand the agent the link
`<chat>/<repo>/<slug>/` as its path. Those workspaces live under
`~/.deck/workspaces`, which settings list as an additional directory so
the agent's edits there do not prompt.

A workspace needs bootstrapping before any tooling runs there: dependency
install at minimum, plus whatever `~/code/workspaces/AGENTS.md` says. Say in the
brief whether you already did this or the agent must.

On cleanup, leave a workspace's working copy alone. Removal is
`jj workspace forget`, which stops tracking and keeps every commit reachable,
and jj simply makes another working-copy commit if one is missing. Never abandon
another workspace's `@`.

The paths clause of the brief is not optional. Name the workspace the agent owns
and state that the main checkout and every other workspace are off limits,
including for reading if a stale read would mislead it.

## The brief

Write what the agent cannot infer. Six parts, and the ones agents most often
fail on are the last two.

```text
where      the workspace path it owns; the paths it must not touch
read       files to read first, in order, with why each one matters
scope      what to build, and which nearby things to leave alone
gate       the exact commands that prove it worked, and the expected result
rules      the standing rules that actually bite here (below)
report     the shape of the final message (next section)
```

Out of scope carries real weight. An agent with a clear goal and no boundary
refactors adjacent code, and you then cannot tell its work from the change you
asked for.

The gate is commands, not intentions. "Add tests" produces a test that passes
against the unmodified code. "Add a test that fails when `<function>` is stubbed
to return null, and paste what it printed" produces evidence.

Standing rules to restate, because a fresh agent does not carry them:

```text
jj, never git; always pass -m, since bare describe/squash/split hang on $EDITOR
commit descriptions are scopedcommits.com style, <scope>: <description>
  (e.g. checkout: drop the stale cart guard); never feat(x): on a commit
never jj edit; to amend an earlier change, jj new <id>, edit, then jj squash
no push, no bookmark move, no PR, no jj git push of any kind
never restart a shared daemon or dev server another agent may be using
never paste raw session content, transcripts or logs into a report or a file;
  they can carry secrets
grep prints nothing in this environment; search with python or sed
~/wiki is edited only through the wiki skill, never by hand
mktemp for scratch files
```

Add the repo's own rules on top when they exist. Drop the ones the task cannot
reach, since a rule list nobody needs is a rule list nobody reads.

## Commit, do not publish

The agent commits its own slices with real descriptions and leaves them in the
log. One commit per coherent piece, so you can read them in order and so a bad
slice can be dropped without unpicking the good ones.

Publishing is yours. Pushing, moving a bookmark, opening a PR and answering
review are all decisions about what Sal sees, and the agent does not know what
Sal asked for or what else is in flight. Tell it this explicitly rather than
assuming restraint.

## The report back

This is the point of the whole exercise. Sal never sees it, so it is written for
you, and every line in it is something you will either verify or relay. Ask for
exactly this:

```text
per slice        what was built, and the change-id, oldest first
tests            what was added and what each one asserts
negative checks  the command run with the code stubbed, and what it printed
brief errors     what in the brief was wrong, missing or ambiguous
undone           what was left, and whether it was scope or a blocker
paths            absolute, always
```

Facts and paths only. Cut the encouragement, the self-assessment and the
restatement of the brief. "What in the brief was wrong" is the highest-value line
in the report and the one agents omit unless asked, because it is the only
channel through which your model of the repo gets corrected.

You relay the substance, never the report. Pasting a sub-agent's text at Sal
hands him an unverified claim in a voice that is not yours.

## When the agent lands

```text
1  read the commits, not the report      jj log -r '<revset>' ; jj show <change-id>
2  run the gate yourself, once           before anything is pushed
3  reconcile                             what the report claims against what the diff does
4  then decide                           push, bookmark, PR, or hand it back
5  tell Sal                              what changed, and what is still open
```

Step 1 holds even for a report you believe: the report describes intent and the
diff is what exists. An agent that stubbed a helper to make its gate pass
writes a truthful report about a broken change.

Step 2 matters most when several agents landed. Rebasing a stack onto a moved
base fixes text and not semantics, so a new required argument added by one agent
compiles in every sibling and fails only at the top.

## Several at once

Normal, and the reason workspaces exist, but no more than two building at
once. One workspace each, fired in a single message so they run concurrently,
and you merge or rebase the siblings at the end. Queue the rest and fire the
next one when one lands.

```text
      default (main checkout, you)
        ├── workspaces/<repo>/a   agent A
        └── workspaces/<repo>/b   agent B
                   ↓
        you rebase or merge, run the gate at the top, then publish
```

Conflicts between siblings are textual and expected when two agents edit one
file. Split the work by file wherever the shape of the task allows it, and where
it does not, say in both briefs which file is contended and which agent owns it.

## What this is not

Not a review. Fanning a review out to several lenses is the `review` skill, and
this skill is about producing work rather than judging it.

Not a way to get past a decision Sal has not made. If the open question is what
he wants, ask him with labelled options and leave room for something else. An
agent will answer the question you asked and produce a confident implementation
of a guess.

Not a context saver on its own. A sub-agent that has to read half the repo to
start costs more than it returns, and the fix is a better read-first list rather
than a second agent.
