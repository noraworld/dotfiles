#!/usr/bin/env zsh

zle -N __fuzzy_push_directory
zle -N __smart_forward

function __fuzzy_push_directory() {
  push_directory

  if [ $? = "0" ]; then
    BUFFER=""
    zle .accept-line
  else
    zle reset-prompt
  fi
}

function __smart_forward() {
  if [ -n "$POSTDISPLAY" ]; then
    zle forward-word

    # "reset-prompt" is necessary because suggested words that have not been typed yet show up with a normal color
    # as if they have already been accepted somehow...
    zle reset-prompt
  else
    zle forward-char
  fi
}
