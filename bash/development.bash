#!/bin/bash

# ndenv
if [[ -s ~/.ndenv ]]; then
  PATH="$HOME/.ndenv/bin:$PATH"
  eval "$(ndenv init -)"
fi

# rbenv
if [[ -s ~/.rbenv ]]; then
  PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# pyenv
if [[ -s ~/.pyenv ]]; then
  PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

# phpenv
if [[ -s ~/.phpenv ]]; then
  PATH="$HOME/.phpenv/bin:$PATH"
  eval "$(phpenv init -)"
fi
