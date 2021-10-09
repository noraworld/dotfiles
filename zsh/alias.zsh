#!/usr/bin/env zsh

# Get the aliases
## General aliases
alias sudo='sudo ' # enable all aliases also at sudo mode
alias restart='exec -l $SHELL'
alias del='trash'

## Overridden aliases
### WARNING: Some scripts may not work properly by overriding a existence command
alias ls='ls --color=auto -N'
alias grep='grep --color=auto'

## Abbreviation aliases
alias d='show_directory_stack'
alias p='push_directory'
alias pop='pop_directory'
alias be='bundle exec'
alias x='xargs -n 1 -o' # usage: which cat | x file
alias ca='cron-apply'
