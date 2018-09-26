# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Export the environment variables
export LSCOLORS=gxfxcxdxbxegedabagacad
export HISTCONTROL=ignoredups
export HISTSIZE=1000000
export PATH
export MANPATH
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'
export LESS='-R'
export PROMPT_COMMAND

# Save the history in the right order
shopt -u histappend

# Share the history for each tab or window
if ! [[ "$PROMPT_COMMAND" =~ "history -a;history -c;history -r" ]]; then
  PROMPT_COMMAND="history -a;history -c;history -r;$PROMPT_COMMAND"
fi
