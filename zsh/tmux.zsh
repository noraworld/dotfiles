#!/usr/bin/env zsh

# Log terminal outputs with tmux

# NOTE 1:
#   Do nothing if it is a SSH session
# NOTE 2:
#   A tty name is not necessarily "login"
#   For example, a tty name of a terminal in VS Code is "/Applications/Visual"

_tty_name=$(ps -eo pid,command | grep "$PPID" | grep -v grep | awk '{ print $2 }')

if [ "$(echo $_tty_name | grep "tmux")" ]; then
  [ -d $SESSION_LOG_PATH ] || mkdir -p $SESSION_LOG_PATH
  tmux pipe-pane "cat >> $SESSION_LOG_PATH/$(date +%Y%m%d_%H%M%S)"
elif [ ! "$(echo $_tty_name | grep "sshd")" ]; then
  tmux
  exit
fi
