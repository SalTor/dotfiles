---
name: deck-metrics
description: File a measurement as a deck metric reading so it can be found again. Use whenever a turn produces a number from a live system: a query against Redshift, MySQL, BigQuery or a warehouse table, a conversion or funnel rate, a count of rows or users or sessions, an experiment result, a before-and-after comparison, or any answer to "what do the analytics say about X". Also use when asked to record, file, or look up a metric, a reading, a baseline, or how a number was concluded.
---

# Filing a measurement

A number you worked out and left in a transcript is a number the next person
re-derives. deck keeps them as artifacts: a metric is the question, and a
reading is one dated answer with the query and the reasoning attached.

```text
~/.deck/metrics/<slug>/metric.md                 the question
~/.deck/metrics/<slug>/readings/<at>-<chat>.md   one answer, never edited
```

## When to file

When you have stated a number and you can say what it counts. File it in the
same turn, without being asked. Sal decided this (2026-09-18): the turn is
one he started, it costs nothing extra, and the command shows in the
transcript where he can see it.

Do not file:

- a number you did not measure, like one read out of a spec or a PR body
- an intermediate count on the way to the answer
- a number you are unsure of. Say you are unsure instead; a reading is a
  thing people will trust later
- anything when he has said not to

## How

Look first. A question already asked has a metric, and a second reading of
it is the whole point.

```bash
deck metrics                      # every metric, with its newest reading
deck metric show <slug>           # the question and every answer to it
```

If it is there, record against it. If it is not, start it and then record.

```bash
deck metric new "Identified share of weekly visitors" \
  --question "what share of weekly site visitors do we hand identifiers for" \
  --unit "percent of distinct anon_id in pages, weekly"

deck metric record identified-share-of-weekly-visitors \
  --value "8.8%" \
  --measures "distinct matched anon_id / distinct anon_id in pages, week of 9/07" \
  --source "redshift fgt_website_prod_javascript" <<'BODY'
## Query

```sql
select …
```

## Answer

8.8% of weekly visitors carry an identifier.

## Caveats

phoneVerify did not exist during the 2024 test, so the SMS path today has an
extra step this comparison does not cover.

## How concluded

Matched anon_ids over all anon_ids seen in pages for the week.
BODY
```

You are inside a deck chat, so `--chat` is filled from `$DECK_CHAT` and the
reading records itself as an agent's, against the right session and project.
Do not pass `--chat` yourself.

## The four fields that matter

```text
--value      the answer as you would say it out loud
--measures   exactly what was counted. THE important one.
--source     the warehouse, table or dashboard
the body     the query verbatim, the answer, the caveats, the reasoning
```

`--measures` is what keeps the reading honest in six months. "8.8%" and
"4.1%" look like the world changed; "distinct matched anon_id over distinct
anon_id in pages, weekly" against "cookie only, before _kx" says the
question moved. Write the definition, not the label.

Quote the query in full in the body. The chat link is provenance and the
body is the reference: deck keeps its own record of this chat forever, but
the Claude Code transcript it points at is not deck's to keep.

## Rules

1. **A reading is never edited or deleted.** Nothing in deck lets you. A
   wrong one is superseded by a later reading that says so, which is why the
   history is worth reading. If you filed something wrong, file the
   correction and say in its body what it corrects.
2. **The same day from this chat twice is refused.** That is not a failure
   to work around. Either you already filed it, or you want `--at` for the
   day the query actually covers.
3. **A number never goes in a project file.** `deck project metric <project>
   <metric-slug>` points a project at a metric; the readings stay here. Do
   not touch `baseline:`, which is a legacy field deck no longer maintains.
4. **Do not invent a second metric for a question that has one.** Two slugs
   asking the same thing is two half-histories. If the definition changed,
   that is a new reading with a different `--measures`, not a new metric.
