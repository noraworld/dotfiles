#!/usr/bin/env zsh

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
  fi
fi
