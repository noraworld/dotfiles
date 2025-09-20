#!/usr/bin/env zsh

zmodload zsh/datetime # $EPOCHREALTIME

fpath=(${ASDF_DIR}/completions $fpath)

autoload -Uz add-zsh-hook

add-zsh-hook preexec __arm
add-zsh-hook precmd  __autols
add-zsh-hook precmd  __git_auto_execute
add-zsh-hook precmd  __unarm

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*:sudo:*' command-path $path
zstyle ':completion:*' format '%B%d%b'

#zstyle ':fzf-tab:complete:*' fzf-flags --preview-window=right:$(expr $(tput cols) - 45) --height=100%
#zstyle ':fzf-tab:complete:git:*' fzf-preview 'git diff --color=always $realpath'
#zstyle ':fzf-tab:complete:*' fzf-bindings 'ctrl-space:toggle+down'
#zstyle ':fzf-tab:complete:ls:*' fzf-preview 'lk $realpath'
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color=always $realpath'

# https://necotech.org/archives/988
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_TYPE=en_US.UTF-8

setopt +o nomatch
setopt interactivecomments
setopt IGNOREEOF
