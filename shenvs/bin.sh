#!/bin/sh

# Set the self-making commands path to environment variables
if [ -e ~/.bin ]; then
  PATH=$HOME/.bin/general:$PATH
  PATH=$HOME/.bin/local:$PATH
  PATH=$HOME/.bin/override:$PATH
  PATH=$HOME/.bin/currentshell:$PATH
  PATH=$HOME/.bin/git_subcommand:$PATH
  PATH=$HOME/.bin/brew_subcommand:$PATH

  if [[ "$(basename $(echo $SHELL))" = "zsh" ]]; then
    fpath=( $HOME/.bin/zsh_completions "${fpath[@]}" )

    while read line; do
      autoload -Uz ${line}
    done < $HOME/.bin/zsh_completions
  fi

  MANPATH="$DOTPATH/man:$MANPATH"

  for cmd in $HOME/.bin/currentshell/*
  do
    cmd=`basename ${cmd}`
    alias ${cmd}="source ${cmd}"
  done
fi
