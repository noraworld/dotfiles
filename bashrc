# Get the aliases
## General aliases
alias sudo='sudo '
alias reload='source ~/.bash_profile'
alias restart='exec -l $SHELL'
alias d='show_directory_stack'
alias p='push_directory'
alias push='push_directory'
alias pop='pop_directory'
alias pushd='echo -e "do not use pushd manually\nuse push instead" && pushd'
alias popd='echo -e "do not use popd manually\nuse pop instead" && popd'
alias g='git'
alias ga='git a'
alias gc='git c'
alias gd='git d'
alias gs='git s'
alias grep='grep --color=always'
alias less='less -iMNRS'
alias hist='history | tac | less | peco'
alias vi='vim'
alias gosearch='cd $(ghq root)/$(ghq list | peco)'
alias again='again=`history | sed "s/^ *[0-9]* *//g" | peco`; echo $again; command $again'
alias laravel='php artisan'
alias rm='echo -e "rm command should not be used\ncommand ignored: rm"'
alias histcpy='histcpy=`history | sed "s/^ *[0-9]* *//g" | tac | less | peco`; echo -n $histcpy | pbcopy; echo "Copied \`$histcpy\` to clipboard"'
alias up='cd ..'

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

# Set DOTPATH
if [ -f ~/.dotpath ]; then
  . ~/.dotpath
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

# Restore directory stack when shell session starts or restarts
# Also see function store_directory_stack() in ./bin/src/override/_pushd
#
# CAUTION: This should be loaded after ./bash/bin.bash is loaded
if [[ -e $HOME/.directory_stack_store ]]; then
  if [[ $(dirs -v | wc -l) -eq 1 ]]; then
    while read line
    do
      # expand tilde into home directory’s path
      # somehow tilde is not expanded
      #
      # NOTE:
      #   use `|` instead of `/` as sed separator
      #   because `/` overlaps with path expression
      file=$(echo $line | sed -e "s|^~|$HOME|g")

      command pushd $file 1>/dev/null
    done << FILE
$(tac $HOME/.directory_stack_store || tail -r $HOME/.directory_stack_store)
FILE

    # delete directory of when shell session starts from stack
    command popd -0 1>/dev/null

    echo -e "Restored directory stack"
    show_directory_stack
    echo
  fi
else
  echo -e "$HOME/.directory_stack_store is not found"
  echo -e "Skip"
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
    show_directory_stack
    echo -e ""
    echo -e "\033[1;92mFILES AND DIRECTORIES:\033[00m"
    ls
    echo ""
  fi

  AUTORUN_DIR="${PWD}"
}

# Load bash-preexec
[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh

# Refer to https://bearmini.hatenablog.com/entry/2016/02/16/222057. Thanks a lot!
_tn_timestamp=`date +%s`
_tn_cmd=''
preexec() {
  _tn_timestamp=`date +%s`
  _tn_cmd=$1
}
precmd() {
  notification_period_threshold=180
  now=`date +%s`
  dur=$(( $now - $_tn_timestamp ))

  if [[ $_tn_cmd == "" ]]; then
    return
  fi

  if [[ ! -e $HOME/.elapsed_time_ignore_commands ]]; then
    touch $HOME/.elapsed_time_ignore_commands
  fi

  is_elapsed_time=true
  while read line
  do
    if [[ $_tn_cmd = $line ]]; then
      is_elapsed_time=false
    fi
  done < $HOME/.elapsed_time_ignore_commands

  if "${is_elapsed_time}"; then
    if [[ $dur -gt notification_period_threshold ]]; then
      terminal-notifier -message "Finished: $_tn_cmd"
    fi

    echo
    if [[ $dur -eq 1 ]]; then
      echo elapsed time: $dur second
    else
      echo elapsed time: $dur seconds
    fi
  fi

  _tn_cmd=''
}

# Use direnv
# It should appear even after shell extensions that manipulate the prompt like git-prompt
if type direnv 1>/dev/null 2>/dev/null; then
  eval "$(direnv hook bash)"
fi
