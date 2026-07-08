#!/usr/bin/env bash
# Claude Code status line. Reads session JSON on stdin.
# Format:  <model>  <~/first/…/last>  <branch>  ctx <pct>% · <tokens>
# Branch is jj-first and understands anonymous branches (no bookmark → change id).
# ctx segment tracks context-window fill so you know when to /compact or start fresh.

input=$(cat)

model=$(printf '%s' "$input" | jq -r '.model.display_name // "?"')
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
# Emits tab-separated "<kind>\t<f1>\t<f2>":
#   kind=b (bookmark/git branch): f1=name, f2 empty
#   kind=a (anonymous change id): f1=unique prefix, f2=remaining chars
raw=$(cd "$dir" 2>/dev/null && {
  if command -v jj >/dev/null 2>&1 && jj root --quiet >/dev/null 2>&1; then
    jj log -r @ --no-graph --ignore-working-copy \
      -T 'if(bookmarks, "b\t" ++ bookmarks.join(",") ++ "\t", "a\t" ++ change_id.shortest(8).prefix() ++ "\t" ++ change_id.shortest(8).rest())' 2>/dev/null
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
# used_percentage + total_input_tokens describe how full the current window is.
read -r pct toks <<< "$(printf '%s' "$input" | jq -r '
  (.context_window.used_percentage // empty | tostring) + " " +
  (.context_window.total_input_tokens // empty | tostring)')"

ctx=""
if [ -n "$pct" ] && [ "$pct" != "null" ]; then
  # tokens as a compact k-count (e.g. 47065 -> 47k)
  if [ -n "$toks" ] && [ "$toks" != "null" ]; then
    k=$(( (toks + 500) / 1000 ))
    tstr="${k}k"
  else
    tstr=""
  fi
  # colour by fill: green <60, yellow 60–79, red ≥80
  if   [ "$pct" -ge 80 ]; then c=$'\033[31m'   # red
  elif [ "$pct" -ge 60 ]; then c=$'\033[33m'   # yellow
  else                         c=$'\033[32m'   # green
  fi
  reset=$'\033[0m'
  ctx="${c}ctx ${pct}%"
  [ -n "$tstr" ] && ctx="$ctx · $tstr"
  ctx="$ctx${reset}"
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

# --- Emit:  {context}  {model}  {path}  {jj info} -----------------------
line=""
[ -n "$ctx" ] && line="$ctx  "
line="$line$model  $short"
[ -n "$branch" ] && line="$line  $branch"
printf '%s' "$line"
