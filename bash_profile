# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Divide configs by OS
case "${OSTYPE}" in
  darwin*)
    if [ -f ~/.bashrc_maxos ]; then
      . ~/.bashrc_maxos
    fi
  ;;
  linux*)
    if [ -f ~/.bashrc_linux ]; then
      . ~/.bashrc_linux
    fi
  ;;
esac

# For Development configs
if [ -f ~/.bashrc_dev ]; then
  . ~/.bashrc_dev
fi

# Export the environment variables
export LSCOLORS=gxfxcxdxbxegedabagacad
export HISTCONTROL=ignoredups
export HISTSIZE=10000
export PATH
