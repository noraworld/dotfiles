# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Export the environment variables
export LSCOLORS=gxfxcxdxbxegedabagacad
export HISTCONTROL=ignoredups
# export HISTIGNORE="history*:hg*:cd*:pushd*:popd*:ls*:dirs*:fg*:bg*:quit*"
export HISTSIZE=10000

export PATH
# node path setting
export PATH=$HOME/.nodebrew/current/bin:$PATH
