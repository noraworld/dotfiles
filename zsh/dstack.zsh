#!/usr/bin/env zsh

# avoids scp failure
# scp fails when something is displayed to stdout at login
# returns 'true' if not scp
is_not_scp() {
  if [ ! -f /proc/$PPID/cmdline ]; then # if not Linux
    echo true
  elif [ -f /proc/$PPID/cmdline ] && [[ "$(cat /proc/$PPID/cmdline | sed 's/\x0//g')" =~ sshd:([[:blank:]]+.*)@notty ]]; then # if scp; use sed to get rid of null bytes
    echo false
  else
    echo true
  fi
}

# Restore directory stack when shell session starts or restarts
# Also see store_directory_stack
#
# CAUTION: This should be loaded after ./zsh/bin.zsh is loaded
if [[ -e $HOME/.directory_stack_store ]]; then
  if [[ $(dirs -v | wc -l) -eq 1 ]]; then
    while read line
    do
      # expand tilde into home directory’s path
      # somehow tilde is not expanded
      #
      # NOTE:
      #   use `|` instead of `/` as sed separator
      #   because `/` overlaps with path expression
      file=$(echo $line | sed -e "s|^~|$HOME|g")

      pushd $file 1>/dev/null
    done << FILE
$(tac $HOME/.directory_stack_store || tail -r $HOME/.directory_stack_store)
FILE

    # delete directory of when shell session starts from stack
    popd -0 1>/dev/null

    if "$(is_not_scp)"; then
      echo -e "Restored directory stack"
      show_directory_stack
    fi
  fi
else
  # echo -e "$HOME/.directory_stack_store is not found"
  :
fi
