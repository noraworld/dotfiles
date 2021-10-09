#!/usr/bin/env zsh

# Get the aliases
## General aliases
alias sudo='sudo ' # enable all aliases also at sudo mode
alias reload='source ~/.zshrc'
alias restart='exec -l $SHELL'
alias hist='history 1 | tac | less | peco'
alias histcpy='histcpy=`history 1 | sed "s/^ *[0-9]* *//g" | tac | less | peco`; echo -n $histcpy | pbcopy; echo "Copied \`$histcpy\` to clipboard"'
alias again='eval $(history 1 | sed "s/^ *[0-9]* *//g" | peco)'
alias gosearch='cd $(ghq root)/$(ghq list | peco)'
alias laravel='php artisan'
alias del='trash'

## Overridden aliases
### Some scripts may not work properly by overriding a existence command
alias grep='grep --color=auto'
alias vi='vim'

## Abbreviation aliases
alias d='show_directory_stack'
alias p='push_directory'
alias push='push_directory'
alias pop='pop_directory'
alias g='git'
alias ga='git a'
alias gc='git c'
alias gd='git d'
alias gs='git s'
alias l='lk'
alias ll='lk -l'
alias la='lk -a'
alias lal='lk -al'
alias lla='lk -la'
alias lt='lk --tree'
alias ltl='lk --tree -l'
alias lta='lk --tree -a'
alias ltal='lk --tree -al'
alias ltla='lk --tree -la'
alias be='bundle exec'
alias x='xargs -n 1 -o'
alias ca='cron-apply'

## Deprecated aliases
alias rm='echo -e "rm command should not be used\ncommand ignored: rm"'
