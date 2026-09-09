---
name: tone
description: Rewrite or draft a PR/MR description or review comment in Sal's own voice, using the human-written golden set at ~/code/tone-of-voice. Use when the user says /tone, "make this sound like me", "in my voice", or wants an AI draft de-scaffolded before posting.
---

# tone

Rewrite a PR/MR description or a review comment so it reads the way Sal writes, using
`~/code/tone-of-voice/` as the reference. Voice only: facts, links, and required template
headings stay.

## Usage

```
/tone                      rewrite the most recent draft in the conversation
/tone <text>               rewrite the given text
/tone <PR URL or number>   rewrite that PR/MR's body (fetch it, show the result, edit remotely only if asked)
/tone check [<text>]       list anti-pattern hits in a draft without rewriting it
```

## Limits

- The output is still AI-drafted
  - The `:robot: Generated with Claude, curated by Sal` attribution still applies to comments posted on a PR/MR; Slack messages and chat replies carry no attribution
  - Never add the output to the golden set
- The guide records em-dashes as a genuine tell; the standing no-em-dash rule wins anyway
- The guide's long-form voice is 2023 to 2025 vintage; confirmed-human samples after 2026-05-08 are short
  - When in doubt, shorter
- Do not manufacture typos, filler hedges, or emoji
  - The guide records them as tells of human writing; adding them on purpose reads as imitation
- Example vocabulary is FGT ecommerce (carts, delivery promises, experiments); borrow the shape of the sentences and leave the subject matter

## Steps

1. Read `~/code/tone-of-voice/TONE-GUIDE.md` in full.
2. Classify the input and read the matching examples file. Skip `_borderline.md`; it is not golden.
   - Description: `pr-descriptions/{feat,fix,chore,refactor}.md` by kind of change
   - Comment: `pr-comments/giving-feedback.md` (reviewing others), `responding.md` (replying to review of own work), `questions.md`, `nits-and-praise.md`
   - Slack messages and issue comments use the comment buckets; a question to a teammate is `questions.md`
   - Keep the 3 to 5 entries closest in situation and length in mind while rewriting
3. Find the input, in this order: the argument text; a PR/MR reference (`gh pr view <n> --repo <slug> --json body -q .body`, or `glab mr view <iid>`); the most recent draft in the conversation. If none, ask once.
4. Rewrite.
   - Keep every fact, link, ticket ref, spec ID, and command
   - Keep the repo's PR template headings when present and fill them tersely
   - Open with the problem or context in plain terms, then the change. "Today, ..." is a real habit; use it when it fits
   - One idea per line, blank lines between, bullets for steps, prose for context
   - Remove what the guide's Anti-patterns section names: `##` sections beyond the template, uniform `**Term** —` bullets, verification checklists with pass counts, "Ready for review" closes, forensic provenance bullets
   - Hedge only where the source hedges; where it is direct, state the reason. Softening a stated conclusion into a question changes the claim, so if it seems warranted, flag it in step 5 rather than doing it silently
   - Comments: lead with a label when one fits (`nit:`, `q:`, `Change:`, `Feedback:`, `Optional:`), suggest with a reason rather than decree, and in a review response concede where warranted and show the tradeoff that was weighed
   - Test notes can be one line: "Manually on my test storefront"
5. Show the result, then what changed and anything inferred (a claim, a why) so the user can correct it.
6. `check` mode: stop after step 3 and list each anti-pattern hit with the offending line.

## Do not

- Edit the golden set. Adding or promoting examples is the manual step in `~/code/tone-of-voice/README.md`
- Post or push the result. `/pr` and `post-feedback` own posting
- Rewrite jj change descriptions; those follow their own convention
