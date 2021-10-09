#!/usr/bin/env zsh

zmodload zsh/datetime
bindkey -e

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:sudo:*' command-path $path
zstyle ':completion:*' format '%B%d%b'

export HISTSIZE=10000
export HISTFILE=~/.zsh_history
export SAVEHIST=9999999999

# https://necotech.org/archives/988
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

setopt +o nomatch
setopt hist_ignore_dups
setopt interactivecomments
setopt inc_append_history
setopt extended_history
setopt IGNOREEOF
