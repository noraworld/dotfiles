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

# Save the history in correct order
shopt -u histappend

# Auto correct and continue to run cd command even if directory name is misspelled partly
#
# disable because this is rarely used
#shopt -s cdspell

# Change directories without `cd`
# NOTE: bash version more than 4.0 is required
#
# On macOS, simply run:
# $ brew install bash
# $ echo /usr/local/bin/bash | sudo tee -a /etc/shells
# $ chpass -s /usr/local/bin/bash
# (Type your password, then reboot your shell application)
#
# somehow this does not work on bash 5.0.11
# though trying above command
# this works on company MacBook Pro
# but does not work on personal MacBook Pro (bash 5.0.11)
#shopt -s autocd
