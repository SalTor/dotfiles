---
name: remind
description: Add a deck reminder for Sal with `deck cron add --remind`. Use when Sal types /remind, or asks in any words to be reminded of something, with or without a time ("remind me at 3pm to check the deploy", "ping me tomorrow about the MR", "every Monday at 9 remind me to ..."). When it fires, deck posts a macOS notification, opens an Inbox item and shows a banner over the composer until Sal presses Done or Snooze. It does not message the agent unless added with --prompt.
---

# /remind

`/remind <what> <when>`, in any order and any words:

```text
/remind check the deploy at 3pm
/remind tomorrow 9am review redwood#2609
/remind in 20 minutes to restart deck
/remind every weekday at 10:15 look at the inbox
```

## Notify only, or also prompt the agent

By default a reminder only notifies Sal: the notification, the Inbox item
and the banner. The agent is not sent anything. The banner has a "Send to
chat" button if Sal wants the agent to see it after all.

Add `--prompt` only when Sal asks for the agent to do something when it
fires ("remind me at 3 and check the deploy then", "at 9 tomorrow, spec
tooling#60"). If you cannot tell, use the default.

## Steps

1. **Read the time.** Get the current local date and time with `date`, never
   from memory. Work out one local date and time (`YYYY-MM-DD HH:MM`) for a
   one-shot, or a five-field cron in local time for "every ...".
   - "at 3pm" with 3pm already past today means today is wrong: ask, do not
     guess tomorrow.
   - No date or time at all: do not ask. Use the next 9:00 (today if it is
     before 9:00, otherwise tomorrow) and say so in the confirmation.
   - A vague time: do not ask. Pick one: "soon" or "later" is in 1 hour,
     "this afternoon" is 14:00, "tonight" or "this evening" is 18:00, "end of
     day" is 17:00; a day with no time ("Thursday") is 9:00 that day.
   - A recurring job more often than hourly needs `--often`; say so and ask
     before adding it.
2. **Write the text.** Its first line is the notification's text: the thing
   to do in Sal's own words, short. No "Reminder for Sal:" or similar
   preamble, since Sal is the only user.
   - Notify only: that line, and at most one more line of context (a PR
     ref, a command, a file).

     ```text
     Check the deploy.
     redwood#2609
     ```

   - With `--prompt`, the same first line, then one line telling this
     chat's agent what to do when it fires:

     ```text
     Spec tooling#60.
     Draft the spec, then say it is ready.
     ```

3. **Add it** from this chat's folder (the session's working directory):

   ```bash
   deck cron add --at "2026-10-13 15:00" --remind <<'EOF'
   Check the deploy.
   EOF
   ```

   Add `--prompt` after `--remind` only as described above. For a recurring
   one, `deck cron add "<min hour day month weekday>" --remind`. Outside a
   deck chat folder the command refuses; say so rather than passing `--chat`
   with a guessed id.
4. **Confirm in one line**, with the id and the time in words, from the
   command's own output, e.g. "Added reminder c7q2: Tue 13 Oct 15:00." Say
   "it will also prompt me" when you used `--prompt`. It shows in the chat's
   Reminders section (`b 8`), where Sal can cancel it. `deck cron rm <id>`
   cancels it from here.

Do nothing else in the turn: no other tools, no work on the thing being
reminded about.
