#!/bin/bash

# Set the self-making commands path to environment variables
if [ -e ~/.bin ]; then
  PATH=$HOME/.bin:$PATH
  PATH=$HOME/.bin/local:$PATH
fi

# Override the commnad aliases
if [ -e ~/.bin/_unlink ]; then
  alias unlink='source _unlink'
fi

if [ -e ~/.bin/_pushd ]; then
  alias pushd='source _pushd'
fi

if [ -e ~/.bin/_rm ]; then
  alias rm='source _rm'
fi

if [ -e ~/.bin/mkcd ]; then
  alias mkcd='source mkcd'
fi
