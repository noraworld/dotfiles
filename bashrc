# Get the aliases
## General aliases
alias sudo='sudo '
alias reload='source ~/.bash_profile'
alias restart='exec -l $SHELL'
alias dirs='dirs -v'
alias grep='grep --color=always'
alias less='less -iMNRS'
alias history='history | tac | less'
alias vi='vim'
alias gosearch='cd $(ghq root)/$(ghq list | peco)'
alias hisexec='command $(history | sed "s/^ *[0-9]* *//g" | peco)'

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

# Load self-making commands path
if [ -e ~/.bash/bin.bash ]; then
  . ~/.bash/bin.bash
fi

# Git completion config
if [ -e /usr/local/git/contrib/completion/git-prompt.sh ]; then
  . /usr/local/git/contrib/completion/git-prompt.sh
fi

if [ -e /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi

# Set colors to ls command
if [ -f ~/.dir_colors ]; then
  eval $(dircolors -b ~/.dir_colors)
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
