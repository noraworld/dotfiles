#!/bin/sh

# POSIX-compatible setup for monthly zsh history management.
# This file is sourced by zsh but avoids zsh-specific syntax.

setopt hist_ignore_dups   # Do not record a command if it is identical to the previous one
setopt inc_append_history # Append each command to the history file immediately after execution
setopt extended_history   # Record timestamps and command durations in the history file

export HISTSIZE=100000      # Number of commands to keep in memory for interactive history search
export SAVEHIST=9999999999  # Maximum number of commands to save to the history file

# Expect LOG_PATH to be set by the environment. If not, do nothing.
case "${LOG_PATH-}" in
  "" ) return 0 2>/dev/null || exit 0;;
esac

year=$(date +%Y)
month=$(date +%m)
base_dir="${LOG_PATH}/log/zsh-history"
year_dir="${base_dir}/${year}"
histfile="${year_dir}/zsh-history_${year}-${month}.zsh_history"

# Ensure directories and the monthly history file exist
if [ ! -d "$year_dir" ]; then
  mkdir -p "$year_dir" 2>/dev/null || :
fi
if [ ! -f "$histfile" ]; then
  : >"$histfile" 2>/dev/null || touch "$histfile" 2>/dev/null || :
fi

# Make this session’s HISTFILE point to the month’s file
export HISTFILE="$histfile"

# Build a chronologically sorted list of all monthly history files
load_list=
if [ -d "$base_dir" ]; then
  # Sort lexicographically so older (YYYY-MM) come first
  load_list=$(find "$base_dir" -type f -name 'zsh-history_*.zsh_history' 2>/dev/null | LC_ALL=C sort)
fi

# Export list for potential external consumers
export ZSH_MONTHLY_HISTORY_FILES="$load_list"

# If running under zsh, load all history files (oldest -> newest)
# Use fc -R if available (zsh provides it). Ignore errors quietly.
if [ -n "${ZSH_VERSION-}" ]; then
  printf '%s\n' "$ZSH_MONTHLY_HISTORY_FILES" | while IFS= read -r f; do
    [ -n "$f" ] || continue
    # Try zsh builtin first; fall back to plain fc in case builtin is shadowed
    builtin fc -R -- "$f" 2>/dev/null || fc -R -- "$f" 2>/dev/null || :
  done
fi
