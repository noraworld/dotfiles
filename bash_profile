# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Export the environment variables
export LSCOLORS=gxfxcxdxbxegedabagacad
export HISTCONTROL=ignoredups
export HISTSIZE=1000000
export PATH
export MANPATH
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'
export LESS='-R'

# Only registers the dispatch event to avoid appending the same value when rebooting the shell
export PROMPT_COMMAND="dispatch"

# Save the history in the right order
shopt -u histappend

# Share the history for each tab or window
export PROMPT_COMMAND_SHARE_HISTORY="command history -a; command history -c; command history -r;"

dispatch() {
  # Save the error code of the previous command
  export EXIT_STATUS="$?"

  local f

  # Load the environment variables named PROMPT_COMMAND_{ANY} as PROMPT_COMMAND
  for f in ${!PROMPT_COMMAND_*}; do
    eval "${!f}"
  done

  unset f
}
