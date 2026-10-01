---
name: archive
description: Archive this deck chat, or the chat given, with `deck chat archive`.
argument-hint: "[chat id]"
disable-model-invocation: true
---

Sal ran this to archive a deck chat. Do it now; do not ask to confirm.

Archiving stops every session in the chat, the one running you included, so
anything you say after the archive call may never be shown. Say it first.

1. The chat is `$ARGUMENTS` if given, else the chat whose folder this
   session runs in.
2. Before archiving, read the chat folder's `workspaces.json` (this
   folder, or `~/.deck/chats/<id>/` for another chat) and, for this chat,
   run `deck chat pr list`. In one short message, name any workspace still
   listed and any PR still open, a line each, so Sal knows what the archive
   leaves behind. Do not remove, land, or close any of them. With nothing
   listed, say nothing.
3. Last, and as your final action, run the archive in one Bash call:
   - this chat: `deck chat archive`
   - another chat: `deck chat archive --chat <id>`

If the command fails, say what it printed and stop.
