#!/bin/bash

# Get the aliases
alias ls='ls --color=auto'

# Get the functions
if [ -f ~/.dir_colors ]; then
  eval $(dircolors -b ~/.dir_colors)
fi
