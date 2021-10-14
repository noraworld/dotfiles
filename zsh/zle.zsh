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

zle -N __smart_forward
