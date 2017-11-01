#!/bin/bash

# Get the aliases
alias ls='ls --color=auto -N'
alias gmacs='/Applications/Emacs.app/Contents/MacOS/Emacs'

# Set the environment variables
PATH=/usr/local/sbin:$PATH                                  # Homebrew
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"        # coreutils
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"  # coreutils manual
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"        # findutils
MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH"  # findutils manual
