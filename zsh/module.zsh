#!/usr/bin/env zsh

zmodload zsh/datetime
bindkey -e

autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook

add-zsh-hook preexec __set_preexec_variable
add-zsh-hook preexec __warn_deprecated_command
add-zsh-hook preexec __caffeinate

add-zsh-hook precmd __set_precmd_variable
add-zsh-hook precmd __autorun
add-zsh-hook precmd __git_autofetch
add-zsh-hook precmd __split_record_logfile
add-zsh-hook precmd __decaffeinate
add-zsh-hook precmd __wakeup
add-zsh-hook precmd __get_prompt_state
add-zsh-hook precmd __return_when_nop # order is important; it must be here
add-zsh-hook precmd __postprocessing

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
