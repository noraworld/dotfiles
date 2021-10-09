#!/usr/bin/env zsh

function fuzzy_push_directory() {
  push_directory

  if [ $? = "0" ]; then
    zle .accept-line
  else
    zle reset-prompt
  fi
}

zle -N fuzzy_push_directory
bindkey '^J' fuzzy_push_directory
