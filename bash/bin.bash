#!/bin/bash

# Set the self-making commands path to environment variables
if [ -e ~/.bin ]; then
  PATH=$HOME/.bin:$PATH
fi

# Override the commnad aliases
if [ -e ~/.bin/_unlink ]; then
  alias unlink='~/.bin/_unlink'
fi
