#!/usr/bin/env zsh

function __fuzzy_push_directory() {
  push_directory

  if [ $? = "0" ]; then
    zle .accept-line
  else
    zle reset-prompt
  fi
}

zle -N __fuzzy_push_directory
