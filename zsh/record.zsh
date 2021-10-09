#!/usr/bin/env zsh

# # Record output in terminal
case "${OSTYPE}" in
  darwin*)
    if [ ! -d $SESSION_LOG_PATH ]; then
      mkdir -p $SESSION_LOG_PATH
    fi

    if [[ "$(ps -e -o pid,command | grep -E "^\s{0,}$PPID" | grep -v grep)" =~ "login" ]]; then
      script -a -F $SESSION_LOG_PATH/recording.log
      exit # exit automatically when not recording
    fi
  ;;
  linux*)
    : # TODO (MEMO: use -f option instead of -F on GNU script command)
  ;;
esac
