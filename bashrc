# Get the aliases
alias sudo='sudo '
alias history='history | tail -r | less'
alias dirs='dirs -v'
alias grep='grep --color=always'
alias less='less -R'

# Git completion config
if [ -f /usr/local/git/contrib/completion/git-prompt.sh ]; then
  . /usr/local/git/contrib/completion/git-prompt.sh
fi

if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

if [ -f /usr/local/git/contrib/completion/git-prompt.sh ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
fi

# Edit prompt
PS1='\[\033[32m\]\h\[\033[33m\]:\[\033[35m\]\W\[\033[31m\]$(__git_ps1)\[\033[33m\] \$ \[\e[0m\]'
