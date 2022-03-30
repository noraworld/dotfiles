#!/usr/bin/env zsh

# Do not change background color when pasting
# cf. https://www.reddit.com/r/zsh/comments/c160o2/command_line_pasted_text/#t1_erbg6hy
zle_highlight=('paste:none')

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
