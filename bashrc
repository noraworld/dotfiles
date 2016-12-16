# Get the aliases
alias sudo='sudo '
alias dirs='dirs -v'
alias history='history | tail -r | less'
alias trash='rmtrash'
# alias man='env LANG=C man'
# alias jman='env LANG=ja_JP.UTF-8 man'
alias hg='history | grep'
alias ld='echo ERROR: cannot execute ld'
alias grep='grep --color=auto'

# Edit prompt
PS1='\[\033[01;32m\]\u:\W $ \[\e[0m\]'
