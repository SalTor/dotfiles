---
name: remind
description: Deck chats only (working directory under ~/.deck/chats/). Add a deck reminder for Sal with `deck cron add --remind`. Outside a deck chat (Claude Code desktop or CLI in a repo) do not use this skill. In a deck chat, use it when Sal types /remind, or asks in any words to be reminded of something, with or without a time ("remind me at 3pm to check the deploy", "ping me tomorrow about the MR", "every Monday at 9 remind me to ..."). When it fires, deck posts a macOS notification, opens an Inbox item and shows a banner over the composer until Sal presses Done or Snooze. A reminder about the day rather than this chat ("every day at 4pm remind me to wind down") is added with --global, and its banner shows over every screen. It does not message the agent unless added with --prompt. Also use it when Sal asks to change an existing reminder ("move my 4pm reminder to 4:30"): `deck cron edit` changes it in place.
---

# /remind

**Deck chats only.** Before anything else, check that the working directory
is under `~/.deck/chats/`. If it is not, stop: run no `deck` command, and
tell Sal this skill only works in a deck chat, so the reminder has to come
from the harness he is in.

`/remind <what> <when>`, in any order and any words:

```text
/remind check the deploy at 3pm
/remind tomorrow 9am review redwood#2609
/remind in 20 minutes to restart deck
/remind every weekday at 10:15 look at the inbox
/remind every day at 4pm to wind down the agents      (global)
```

## This chat, or global

A reminder belongs to this chat by default: its banner shows above this
chat's composer only.

Add `--global` when the reminder is not about this chat: about the day,
every chat, or Sal himself ("every day at 4pm wind down the agents",
"remind me at 5 to stop for the day", "every Monday at 9 look at the
board"). Its banner then shows above the window on every screen until
Done or Snooze. A global reminder can only notify, so never use
`--prompt` with it; if Sal also wants this chat's agent to act, it is a
chat reminder, not a global one. If you cannot tell, keep it in the chat.

`--snooze <duration>` (for example `--snooze 5m`) gives the banner one
snooze button of that length, pressable again each time it comes back,
with the 10 min / 1 hour / tomorrow menu beside it. Use it when Sal names a
snooze length ("that I can snooze for 5 minutes at a time").

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

   A global reminder works from any folder:

   ```bash
   deck cron add "0 16 * * 1-5" --global --remind --snooze 5m <<'EOF'
   Wind down: hand off every running chat for tomorrow.
   EOF
   ```
4. **Confirm in one line**, with the id and the time in words, from the
   command's own output, e.g. "Added reminder c7q2: Tue 13 Oct 15:00." Say
   "it will also prompt me" when you used `--prompt`. It shows in the chat's
   Reminders section (`b 8`), where Sal can cancel it. `deck cron rm <id>`
   cancels it from here. A global one says "Added global reminder …"; it is
   listed under Global in the rail's Reminders place, `deck cron list
   --global` shows it, and `deck cron rm --global <id>` cancels it.

Do nothing else in the turn: no other tools, no work on the thing being
reminded about.

## Changing an existing reminder

When Sal asks to change a reminder that already exists ("move my 4pm
reminder to 4:30", "make the wind-down one snooze for 10 minutes", "change
the deploy reminder to say redwood#2611"), edit it in place with
`deck cron edit` rather than removing it and adding another: it keeps its
id and its last fire, and a new time works out its next fire again.

1. **Find its id** with `deck cron list` in this chat, or
   `deck cron list --global` for a global one. If more than one could be
   meant, ask which. Read the time as in step 1 above.
2. **Give only what changes.** A new time is a cron expression after the
   id, or `--at` (either may switch between recurring and one-shot). The
   flags are add's, plus `--no-remind`, `--no-prompt` and `--no-snooze`.
   New text goes on stdin; without stdin the text stays as it was.

   ```bash
   deck cron edit c7q2 --at "2026-10-16 16:30"
   deck cron edit --global wd01 "30 16 * * 1-5"
   deck cron edit --global wd01 --snooze 10m
   deck cron edit c7q2 <<'EOF'
   Check the deploy.
   redwood#2611
   EOF
   ```

3. **Confirm in one line** from the command's output, e.g. "Moved reminder
   c7q2 to Fri 16 Oct 16:30." A fired one-shot has ended and cannot be
   edited: say so, and add a new one if Sal still wants it.

As with an add, do nothing else in the turn.
