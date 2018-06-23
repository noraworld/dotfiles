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
