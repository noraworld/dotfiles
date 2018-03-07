#!/bin/bash

# Set the self-making commands path to environment variables
if [ -e ~/.bin ]; then
  PATH=$HOME/.bin:$PATH
  PATH=$HOME/.bin/local:$PATH
fi

# Override the commnad aliases
if [ -e ~/.bin/_unlink ]; then
  alias unlink='~/.bin/_unlink'
fi

if [ -e ~/.bin/_pushd ]; then
  . ~/.bin/_pushd
fi

if [ -e ~/.bin/_rm ]; then
  alias rm='~/.bin/_rm'
fi
