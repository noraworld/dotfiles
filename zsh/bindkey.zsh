#!/usr/bin/env zsh

bindkey -e # use emacs-like key bindings

bindkey -r '^J'
bindkey '^G' __fuzzy_push_directory
bindkey '^F' __smart_forward
