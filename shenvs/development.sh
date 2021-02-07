#!/bin/sh

# anyenv (Homebrew / macOS)
if type anyenv 1>/dev/null 2>/dev/null; then
  eval "$(anyenv init -)"
fi

# anyenv (Git / Ubuntu)
if [[ -s ~/.anyenv ]]; then
  PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
fi

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

# gopath
if [ -s ~/.go ]; then
  export GOPATH=$HOME/.go
  PATH="$GOPATH/bin:$PATH"
fi
