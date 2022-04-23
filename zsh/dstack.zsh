#!/usr/bin/env zsh

# Restore directory stack when shell session starts or restarts
# Also see store_directory_stack
#
# NOTE: This should be loaded after zsh/path.zsh is loaded
#       because it uses GNU sed and GNU tac
#
if [ -e $HOME/.directory_stack_store ] && [[ "$(dirs -v | wc -l)" -eq 1 ]]; then
  if [ "$(echo $OSTYPE | grep -c -e "^darwin")" -eq 1 ]; then
    eval $(tail -r $HOME/.directory_stack_store | sed -r "s|^[0-9]+\t(.*)|pushd \"\1\" 1>/dev/null;|g")
  else
    eval $(tac $HOME/.directory_stack_store | sed -r "s|^[0-9]+\t(.*)|pushd \"\1\" 1>/dev/null;|g")
  fi

  popd -0 1>/dev/null # delete directory of when shell session starts from stack
fi
