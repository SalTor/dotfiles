---
name: deck-metrics
description: File a measurement so it can be found again, as a wiki evidence run (deck metrics are retired; never run `deck metric new` or `deck metric record`). Use whenever a turn produces a number from a live system: a query against Redshift, MySQL, BigQuery or a warehouse table, a Sentry count, a conversion or funnel rate, a count of rows or users or sessions, an experiment result, a before-and-after comparison, or any answer to "what do the analytics say about X". Also use when asked to record, file, or look up a metric, a reading, a baseline, or how a number was concluded.
---

# Filing a measurement

A number worked out and left in a transcript is a number the next person
re-derives. It goes in the team wiki as an evidence run: a dated, re-runnable
query and its result, next to the question it answers.

deck metrics are retired (Sal, 2026-11-13). Do not run `deck metric new` or
`deck metric record`; a hook refuses both. `deck metrics` and `deck metric show`
still read the old ones.

## Where

```text
~/wiki/<subject>/evidence/<question-slug>/QUESTION.md           the question
~/wiki/<subject>/evidence/<question-slug>/runs/<date>-<handle>/  one answer, never edited
    RUN.md
    <query-name>/query.sql | query.cwl | query.sh
    <query-name>/result.csv
```

The rules are binding and live in `~/wiki/AGENTS.md`, section Evidence: the
frontmatter, the SQL layout, aggregates only, no local paths. Read it before the
first run of a session.

## When

When you have stated a number and can say what it counts, file it in the same
turn without being asked. Do not file:

- a number you did not measure, like one read out of a spec or a PR body
- an intermediate count on the way to the answer
- a number you are unsure of; say you are unsure instead
- anything when Sal has said not to

## How

1. Look first: `ls ~/wiki/*/evidence/` and the wiki index. A question already
   asked gets a new run, not a second question.
2. Work in a wiki workspace (`~/wiki/AGENTS.md`, Collaboration), never in
   `~/wiki` itself.
3. Write each query in the house layout, then run that file and save its
   output, so the stored query is the one that produced the result:
   `psql "<url>" -v ON_ERROR_STOP=1 --csv -f query.sql > result.csv`.
4. Write `RUN.md` (`at`, `ran_at`, `value`, `measures`, `by`, `informs`,
   `queries`, then Answer, Caveats, How concluded) and add the run's row to
   `QUESTION.md`.
5. `friday lint evidence <question folder>`, commit, `friday publish`.
6. Link the run from the page the number informs.

`measures` is the field that keeps a run honest later: write the definition
(what was counted, over what, in which window), not the label.

A run is never edited. To fix one, add a run that `corrects:` it.
