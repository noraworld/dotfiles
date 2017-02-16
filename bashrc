# Get the aliases
alias sudo='sudo '
alias history='history | tail -r | less'
alias dirs='dirs -v'
alias grep='grep --color=always'
alias less='less -R'

# Divide configs by OS
case "${OSTYPE}" in
  darwin*)
    if [ -f ~/.bashrc_maxos ]; then
      . ~/.bashrc_maxos
    fi
  ;;
  linux*)
    if [ -f ~/.bashrc_linux ]; then
      . ~/.bashrc_linux
    fi
  ;;
esac

# For development configs
if [ -f ~/.bashrc_dev ]; then
  . ~/.bashrc_dev
fi

# For production configs
if [ -f ~/.bashrc_pro ]; then
  . ~/.bashrc_pro
fi

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
if type __git_ps1 1>/dev/null 2>/dev/null; then
  PS1='\[\033[32m\]\h\[\033[33m\]:\[\033[35m\]\W\[\033[31m\]$(__git_ps1)\[\033[33m\] \$ \[\e[0m\]'
else
  PS1='\[\033[32m\]\h\[\033[33m\]:\[\033[35m\]\W\[\033[33m\] \$ \[\e[0m\]'
fi
