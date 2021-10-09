#!/usr/bin/env zsh

PATH="/usr/local/sbin:$PATH"                               # Homebrew

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"       # GNU coreutils
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH" # GNU coreutils manual

PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"       # GNU findutils
MANPATH="/usr/local/opt/findutils/libexec/gnuman:$MANPATH" # GNU findutils manual

PATH="/usr/local/opt/gnu-getopt/bin:$PATH"                 # GNU getopt
MANPATH="/usr/local/opt/gnu-getopt/share/man:$MANPATH"     # GNU getopt manual

PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"         # GNU sed
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"   # GNU sed manual

PATH="/usr/local/opt/openssl/bin:$PATH" # OpenSSL; otherwise LibreSSL
