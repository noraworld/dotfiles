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
export EDITOR=vim

# Save the history in the right order
shopt -u histappend

# Auto correct and continue to run cd command even if directory name is misspelled partly
shopt -s cdspell
