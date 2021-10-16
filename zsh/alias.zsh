#!/usr/bin/env zsh

# General
alias sudo='sudo ' # enable all aliases also at sudo mode
alias reload='source ~/.zshrc'
alias restart='exec -l $SHELL'
alias del='trash'

# Overridden
alias ls='ls --color=auto -N'
alias grep='grep --color=auto'
# WARNING:
#   Do not override commands unduly
#   because some commands may not work properly
#   by overriding the default behaviors

# Abbreviation
alias d='show_directory_stack'
alias p='push_directory'
alias pop='pop_directory'
alias be='bundle exec'
alias x='xargs -n 1 -o' # usage: which cat | x file
alias ca='cron-apply'

if [[ "${OSTYPE}" =~ "linux*" ]]; then
  # https://github.com/sharkdp/bat/blob/994c21a5e14588dd252f1503ae06683baf8f3ffa/README.md#:~:text=Important%3A%20If%20you,with%20other%20distributions
  alias bat='batcat'
fi
