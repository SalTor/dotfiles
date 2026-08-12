#!/usr/bin/env bash
# Claude Code status line. Reads session JSON on stdin.
# Format:  🧠 <used>/<max>  <model>  ⚡ <effort>  <~/first/…/last>
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

# --- Reasoning effort level -------------------------------------------
# effort.level is the live session level (what /effort sets), absent when the
# current model has no reasoning-effort control.
effort=$(printf '%s' "$input" | jq -r '.effort.level // empty')
effort_seg=""
if [ -n "$effort" ]; then
  case "$effort" in
    max)    ec=$'\033[31m' ;;   # red
    xhigh)  ec=$'\033[35m' ;;   # magenta
    high)   ec=$'\033[33m' ;;   # yellow
    *)      ec=$'\033[2m'  ;;   # dim (low, medium)
  esac
  bolt=$'\342\232\241'   # U+26A1 high voltage
  effort_seg="${bolt} ${ec}${effort}"$'\033[0m'
fi

# --- Emit:  {context}  {model}  {effort}  {path} -----------------------
# Join non-empty segments with a double-space separator.
line=""
for seg in "$ctx" "$model" "$effort_seg" "$short"; do
  [ -z "$seg" ] && continue
  if [ -z "$line" ]; then line="$seg"; else line="$line  $seg"; fi
done
printf '%s' "$line"
