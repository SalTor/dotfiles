#!/usr/bin/env bash
# Claude Code status line. Reads session JSON on stdin.
# Format:  <change-id>  🧠 <used>/<max>  <model>  <~/first/…/last>  <PRs>
# Branch is jj-first (always the change id; bookmarks ignored), git branch otherwise.
# 🧠 segment tracks context-window fill (colour = how full) so you know when to /compact.

input=$(cat)

# Strip any trailing "(… context)" note (e.g. "Opus 4.8 (1M context)"); the
# window size is shown in the ctx segment instead, so it's redundant here.
model=$(printf '%s' "$input" | jq -r '.model.display_name // "?"' | sed -E 's/ *\([^)]*context\)//')
dir=$(printf '%s' "$input" | jq -r '.workspace.current_dir // .cwd // empty')
[ -z "$dir" ] && dir="$PWD"

# --- Collapse path to ~/first/…/last ------------------------------------
home="$HOME"
if [ "$dir" = "$home" ]; then
  short="~"
else
  case "$dir" in
    "$home"/*) base="~/"; rest="${dir#"$home"/}" ;;
    *)         base="/";  rest="${dir#/}" ;;
  esac
  IFS='/' read -ra parts <<< "$rest"
  n=${#parts[@]}
  if [ "$n" -le 2 ]; then
    short="$base$rest"
  else
    short="$base${parts[0]}/…/${parts[$((n-1))]}"
  fi
fi

# --- Branch: jj first, then git (evaluated in the session's directory) --
# For jj we always show the change id (bookmarks are ignored on purpose).
# Emits tab-separated "<kind>\t<f1>\t<f2>":
#   kind=a (jj change id):   f1=unique prefix, f2=remaining chars
#   kind=b (git branch only): f1=name, f2 empty
raw=$(cd "$dir" 2>/dev/null && {
  if command -v jj >/dev/null 2>&1 && jj root --quiet >/dev/null 2>&1; then
    jj log -r @ --no-graph --ignore-working-copy \
      -T '"a\t" ++ change_id.shortest(8).prefix() ++ "\t" ++ change_id.shortest(8).rest()' 2>/dev/null
  elif command -v git >/dev/null 2>&1; then
    b=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    [ -n "$b" ] && printf 'b\t%s\t' "$b"
  fi
})
kind=""; f1=""; f2=""
if [ -n "$raw" ]; then
  IFS=$'\t' read -r kind f1 f2 <<< "$raw"
fi

# --- Context-window usage ----------------------------------------------
# used_percentage + total_input_tokens describe how full the current window is;
# context_window_size is the window's max (e.g. 200000 or 1000000).
# Emit all three space-joined; a missing field becomes "" (not an empty jq
# stream, which would collapse the whole concatenation and drop the others).
read -r pct toks max <<< "$(printf '%s' "$input" | jq -r '[
  (.context_window.used_percentage // ""),
  (.context_window.total_input_tokens // ""),
  (.context_window.context_window_size // "")
] | map(tostring) | join(" ")')"

ctx=""
if [ -n "$pct" ] && [ "$pct" != "null" ]; then
  # tokens as a compact k-count (e.g. 47065 -> 47k), with the window max
  # appended as "used/max" (e.g. 44k/1M).
  if [ -n "$toks" ] && [ "$toks" != "null" ]; then
    k=$(( (toks + 500) / 1000 ))
    tstr="${k}k"
    if [ -n "$max" ] && [ "$max" != "null" ] && [ "$max" -gt 0 ] 2>/dev/null; then
      if [ "$max" -ge 1000000 ]; then
        mm=$(( max / 1000000 )); rem=$(( (max % 1000000) / 100000 ))
        if [ "$rem" -eq 0 ]; then maxstr="${mm}M"; else maxstr="${mm}.${rem}M"; fi
      else
        maxstr="$(( (max + 500) / 1000 ))k"
      fi
      tstr="${tstr}/${maxstr}"
    fi
  else
    tstr=""
  fi
  # colour by fill: green <60, yellow 60–79, red ≥80
  if   [ "$pct" -ge 80 ]; then c=$'\033[31m'   # red
  elif [ "$pct" -ge 60 ]; then c=$'\033[33m'   # yellow
  else                         c=$'\033[32m'   # green
  fi
  reset=$'\033[0m'
  # 🧠 <used>/<max> (e.g. 🧠 44k/1M). The fill % is conveyed by the colour
  # instead of a number; fall back to the % only if token counts are absent.
  brain=$'\360\237\247\240'   # U+1F9E0 brain emoji
  ctx="${brain} ${c}${tstr:-${pct}%}${reset}"
fi

# --- Render the branch with a glyph; mimic jj's unique-prefix highlight ---
#   bookmark / git branch -> magenta name
#   anonymous change id    -> bright unique prefix + dimmed remainder (cyan)
icon=$'\356\202\240'   # U+E0A0 branch glyph (UTF-8 EE 82 A0; Starship's default)
reset=$'\033[0m'
branch=""
if [ "$kind" = "a" ]; then
  branch="${icon} "$'\033[1;36m'"${f1}"$'\033[0m'$'\033[2;36m'"${f2}"$'\033[0m'
elif [ "$kind" = "b" ] && [ -n "$f1" ]; then
  branch="${icon} "$'\033[35m'"${f1}${reset}"
fi

# --- Stack PR numbers (jj bookmarks in trunk()..@ mapped via gh, cached) ---
# pr.* in the status JSON only covers the current branch's single PR, so we
# enumerate the stack ourselves. gh is a network call -> cache 60s per session;
# the jj part stays live. Each #NNN is an OSC 8 hyperlink to the PR.
stack_prs=""
if [ -n "$kind" ] && command -v gh >/dev/null 2>&1; then
  sid=$(printf '%s' "$input" | jq -r '.session_id // "x"')
  cache="${TMPDIR:-/tmp}/cc-stack-prs-$sid.json"
  if [ ! -f "$cache" ] || [ $(( $(date +%s) - $(stat -f %m "$cache" 2>/dev/null || echo 0) )) -gt 60 ]; then
    (cd "$dir" 2>/dev/null && gh pr list --state open --json number,headRefName,url --limit 50 2>/dev/null) \
      > "$cache.tmp" 2>/dev/null && mv "$cache.tmp" "$cache" 2>/dev/null
  fi
  # stack bookmarks, top-of-stack first (jj log default order)
  bms=$(cd "$dir" 2>/dev/null && jj log -r 'trunk()..@' --no-graph --ignore-working-copy \
        -T 'bookmarks.join(",") ++ "\n"' 2>/dev/null | tr ',' '\n' | sed '/^$/d')
  if [ -s "$cache" ] && [ -n "$bms" ]; then
    nums=""
    while IFS= read -r bm; do
      [ -z "$bm" ] && continue
      pair=$(jq -r --arg b "$bm" '.[]|select(.headRefName==$b)|"\(.number)\t\(.url)"' "$cache" 2>/dev/null | head -1)
      [ -z "$pair" ] && continue
      IFS=$'\t' read -r num url <<< "$pair"
      [ -z "$num" ] && continue
      # OSC 8 hyperlink (clickable in iTerm2/Kitty/WezTerm; plain text elsewhere)
      link=$'\033]8;;'"$url"$'\a'"#${num}"$'\033]8;;\a'
      nums="$nums $link"
    done <<< "$bms"
    nums="${nums# }"
    [ -n "$nums" ] && stack_prs=$'\033[34m'"PR ${nums}"$'\033[0m'
  fi
fi

# --- Emit:  {jj change id}  {context}  {model}  {path}  {stack PRs} -----
# Join non-empty segments with a double-space separator.
line=""
for seg in "$branch" "$ctx" "$model  $short" "$stack_prs"; do
  [ -z "$seg" ] && continue
  if [ -z "$line" ]; then line="$seg"; else line="$line  $seg"; fi
done
printf '%s' "$line"
