#!/usr/bin/env zsh

# Log terminal outputs with tmux
# cf. https://memo.laughk.org/articles/2014-12-09-tmux-ssh-logging/
# cf. https://q4a.hatenadiary.org/entry/20101029/1288359658

# NOTE 1:
#   Do nothing if it is a SSH session
# NOTE 2:
#   A tty name is not necessarily "login"
#   For example, a tty name of a terminal in VS Code is "/Applications/Visual"

_tty_name=$(ps -eo pid,command | grep "$PPID" | grep -v grep | awk '{ print $2 }')
_record_filename="$(date +%Y%m%d_%H%M%S).log"

if [ "$(echo $_tty_name | grep "tmux")" ]; then
  [ -d $SESSION_LOG_PATH ] || mkdir -p $SESSION_LOG_PATH
  tmux -u pipe-pane "cat >> $SESSION_LOG_PATH/../$_record_filename"
elif [ ! "$(echo $_tty_name | grep "sshd")" ] && type tmux 1>/dev/null 2>/dev/null; then
  tmux -u
  mv $SESSION_LOG_PATH/../$_record_filename $SESSION_LOG_PATH/$_record_filename
  exit
fi
