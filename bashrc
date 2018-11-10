# Get the aliases
## General aliases
alias sudo='sudo '
alias reload='source ~/.bash_profile'
alias restart='exec -l $SHELL'
alias dirs='dirs -v'
alias grep='grep --color=always'
alias less='less -iMNRS'
alias hist='history | tac | less | peco'
alias vi='vim'
alias gosearch='cd $(ghq root)/$(ghq list | peco)'
alias again='again=`history | sed "s/^ *[0-9]* *//g" | peco`; echo $again; command $again'
alias laravel='php artisan'
alias rm='echo -e "rm command should not be used\ncommand ignored: rm"'
alias del='rmtrash'

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

# Show Git branch on prompt
if type __git_ps1 1>/dev/null 2>/dev/null; then
  PS1='\[\033[32m\]\h\[\033[33m\]:\[\033[35m\]\W\[\033[31m\]$(__git_ps1)\[\033[33m\] \$ \[\e[0m\]'
else
  PS1='\[\033[32m\]\h\[\033[33m\]:\[\033[35m\]\W\[\033[33m\] \$ \[\e[0m\]'
fi

# Share the history for each tab or window
if ! [[ "$PROMPT_COMMAND" =~ "history -a;history -c;history -r" ]]; then
  PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
fi

# Run specific command automatically when changing directories
if ! [[ "$PROMPT_COMMAND" =~ "autorun" ]]; then
  PROMPT_COMMAND="autorun;$PROMPT_COMMAND"
fi

autorun() {
  if [[ -n $AUTORUN_DIR ]] && [[ $AUTORUN_DIR != $PWD ]]; then
    echo -e ""
    echo -e "\033[1;92mDIRECTORY STACK:\033[00m"
    dirs
    echo -e ""
    echo -e "\033[1;92mFILES AND DIRECTORIES:\033[00m"
    ls
    echo ""
  fi

  AUTORUN_DIR="${PWD}"
}

# Use direnv
# It should appear even after shell extensions that manipulate the prompt like git-prompt
if type direnv 1>/dev/null 2>/dev/null; then
  eval "$(direnv hook bash)"
fi
