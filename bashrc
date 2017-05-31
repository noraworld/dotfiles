# Get the aliases
## General aliases
alias sudo='sudo '
alias load='source ~/.bash_profile'
alias dirs='dirs -v'
alias grep='grep --color=always'
alias less='less -R'
alias vi='vim'
alias gosearch='cd $(ghq root)/$(ghq list | peco)'

## Override the commnad aliases
if [ -e ~/.bin/_unlink ]; then
  alias unlink='~/.bin/_unlink'
fi

# Set self-making command path to environment variables
if [ -e ~/.bin ]; then
  PATH=$HOME/.bin:$PATH
fi

# Divide configs by OS
case "${OSTYPE}" in
  darwin*)
    if [ -e ~/.bash/macos.bash ]; then
      . ~/.bash/macos.bash
    fi
  ;;
  linux*)
    if [ -e ~/.bash/linux.bash ]; then
      . ~/.bash/linux.bash
    fi
  ;;
esac

# For development configs
if [ -e ~/.bash/development.bash ]; then
  . ~/.bash/development.bash
fi

# For production configs
if [ -e ~/.bash/production.bash ]; then
  . ~/.bash/production.bash
fi

# Git completion config
if [ -e /usr/local/git/contrib/completion/git-prompt.sh ]; then
  . /usr/local/git/contrib/completion/git-prompt.sh
fi

if [ -e /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

if [ -e /usr/local/git/contrib/completion/git-prompt.sh ]; then
  GIT_PS1_SHOWDIRTYSTATE=true
fi

# Edit prompt
if type __git_ps1 1>/dev/null 2>/dev/null; then
  PS1='\[\033[32m\]\h\[\033[33m\]:\[\033[35m\]\W\[\033[31m\]$(__git_ps1)\[\033[33m\] \$ \[\e[0m\]'
else
  PS1='\[\033[32m\]\h\[\033[33m\]:\[\033[35m\]\W\[\033[33m\] \$ \[\e[0m\]'
fi
