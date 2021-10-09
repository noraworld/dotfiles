#!/usr/bin/env zsh

# Refer to https://bearmini.hatenablog.com/entry/2016/02/16/222057. Thanks a lot!

_tn_timestamp=`echo $EPOCHREALTIME`
_tn_cmd=''
_tn_caffeinate_pid=''
need_caffeine=true
_bury_message=''

function __set_preexec_variable() {
  _tn_timestamp=`echo $EPOCHREALTIME`
  _tn_cmd=$1
}

function __warn_deprecated_command() {
  while read line
  do
    deprecated_command=`echo "$line," | cut -d ',' -f 1`
    substitute_command=`echo "$line," | cut -d ',' -f 2`
    reason=`echo "$line," | cut -d ',' -f 3`
    if [[ $_tn_cmd =~ ^([[:blank:]]+.*)*$deprecated_command([[:blank:]]+.*)*$ ]] || [[ $_tn_cmd =~ ^([[:blank:]]+.*)*sudo([[:blank:]]+.*)*$deprecated_command([[:blank:]]+.*)*$ ]]; then
      if [[ "${substitute_command}" != "" ]]; then
        echo -e "\033[1;33mWARNING:\033[00m Command \`\033[1m$deprecated_command\033[00m' is deprecated or dangerous. Use \`\033[1m$substitute_command\033[00m' command instead, or use it very carefully."
      elif [[ "${substitute_command}" = "" ]]; then
        echo -e "\033[1;33mWARNING:\033[00m Command \`\033[1m$deprecated_command\033[00m' is deprecated or dangerous. It should not be used, or should be used very carefully."
      else
        echo -e "Something went wrong!"
      fi

      if [[ "${reason}" != "" ]]; then
        echo "         Reason: $reason."
      fi
      echo -e "         Use \`\033[1mdep\033[00m' command to list all deprecated (or dangerous) and substitute commands.\n"

      echo -e "\033[1;31mNOT RECOMMENDED:\033[00m \033[2mSend STOP signal (^Z) to continue anyway\033[00m"
      echo -e "\033[1;32mRECOMMENDED:\033[00m     \033[1mSend SIGINT signal (^C) to abort\033[00m\n"

      echo -en "Type signal: "

      sleep infinity
    fi
  done < $DOTPATH/DEPRECATED_COMMAND_LIST
}

function __caffeinate() {
  if [[ ${OSTYPE} =~ darwin* ]]; then
    # do not caffeinate when command in DECAFFEINATED_COMMAND_LIST is executed
    need_caffeine=true
    while read line
    do
      if [[ $_tn_cmd =~ ^([[:blank:]]+.*)*$line([[:blank:]]+.*)*$ ]]; then
        need_caffeine=false
      fi
    done < $DOTPATH/DECAFFEINATED_COMMAND_LIST

    # caffeinate
    if type caffeinate 1>/dev/null 2>/dev/null && "${need_caffeine}"; then
      # https://walkingmask.hatenablog.com/entry/2016/09/21/202509
      (caffeinate -d & echo $!) | read _tn_caffeinate_pid
    fi

    # check if `caffeinate` command running
    # prints warning message if `caffeinate` command not running, or `caffeinate` command running but caffeinate pid is wrong or missing
    if "${need_caffeine}"; then
      if ! { [ "$(ps aux | grep caffeinate | grep "$_tn_caffeinate_pid" | grep -cv grep)" -eq 1 ] && [[ "$_tn_caffeinate_pid" =~ ^[0-9]+$ ]]; } then
        echo -e "\033[1;93mWARNING:\033[00m Running out of caffeine! Computer may sleep while executing \`\033[1m$_tn_cmd\033[00m' if it takes long time\033[00m"
        echo
      fi
    fi
  else
    need_caffeine=false
  fi
}

function __set_precmd_variable() {
  now=`echo $EPOCHREALTIME`
  dur_float=`echo "scale=10; $now - $_tn_timestamp" | bc | sed 's/^\./0./'`
  dur_int=`echo $dur_float | sed 's/\.[0-9,]*$//g'`
}

function __autorun() {
  if [[ -n $AUTORUN_DIR ]] && [[ $AUTORUN_DIR != $PWD ]]; then
    store_directory_stack
    echo -e ""
    echo -e "\033[1;92mDIRECTORY STACK:\033[00m"
    show_directory_stack
    echo -e ""
    echo -e "\033[1;92mFILES AND DIRECTORIES:\033[00m"
    ls
  fi

  AUTORUN_DIR="${PWD}"
}

function __git_autofetch() {
  if [[ -d .git ]]; then
    # file name ".git-fetch-last-update" cannot be changeable because that should be written in gitignore_global
    if [[ ! -f .git-fetch-last-update ]]; then
      echo
      echo -e "\033[1;33mInfo: Executing \`git fetch\` in the background to synchronize with the remote branch.\033[00m"
      (git fetch   > /dev/null 2>&1 &)
      (git refresh > /dev/null 2>&1 &) # on the way
      echo $now > .git-fetch-last-update
    fi

    _git_fetch_duration=$(echo "scale=10; $now - $(cat .git-fetch-last-update)" | bc | sed 's/^\./0./' | sed 's/\.[0-9,]*$//g')

    _git_fetch_period_threshold=''
    if [[ -f .git-fetch-period-threshold ]]; then
      _git_fetch_period_threshold=$(cat .git-fetch-period-threshold)
    else
      _git_fetch_period_threshold=$GIT_FETCH_PERIOD_THRESHOLD
    fi

    if [[ $_git_fetch_duration -ge $_git_fetch_period_threshold ]]; then
      echo
      echo -e "\033[1;33mINFO: Executing \`git fetch\` in the background to synchronize with the remote branch.\033[00m"
      (git fetch   > /dev/null 2>&1 &)
      (git refresh > /dev/null 2>&1 &) # on the way
      echo $EPOCHREALTIME > .git-fetch-last-update
    fi
  fi
}

function __split_record_logfile() {
  if [[ -d $SESSION_LOG_PATH ]] && [[ $(cat $SESSION_LOG_PATH/recording.log | wc -l) -ge $SESSION_LOG_SIZE ]]; then
    src_path=$SESSION_LOG_PATH/recording.log
    dst_path=$SESSION_LOG_PATH/typescript_$(date '+%Y-%m-%d_%H-%M-%S').log

    cp $src_path $dst_path
    echo > $src_path
    echo
    echo -e "INFO: $src_path exceeds $SESSION_LOG_SIZE lines. Moved to $dst_path automatically."
  fi
}

function __decaffeinate() {
  # stop caffeinate
  if "${need_caffeine}" && [[ "$_tn_caffeinate_pid" =~ ^[0-9]+$ ]]; then
    kill "$_tn_caffeinate_pid"
  fi
  _tn_caffeinate_pid=''
}

function __wakeup() {
  # stop sleep (for deprecated command stopper)
  _bury_message=`bury -y sleep`
  if [[ $_bury_message != "No processes exist." ]]; then
    echo
    echo $_bury_message
  fi
  _bury_message=''
}

# reload prompt state
function __get_prompt_state() {
  PROMPT_STATE="$(recording_prompt) with ☕️ $(caffeine_count) with 🌡  $(temperature)"
}

function __return_when_nop() {
  # above here is executed even if no command specified on prompt
  ###################################################################
  if [[ $_tn_cmd == "" ]]; then
    echo
    return
  fi
  ###################################################################
  # below here is executed only when some kind of command is executed
}

function __get_notified() {
  is_enabled_notification=true
  while read line
  do
    if [[ $_tn_cmd =~ ^$line([[:blank:]]+.*)*$ ]]; then
      is_enabled_notification=false
    fi
  done < $DOTPATH/NOTIFICATION_SKIP_COMMAND_LIST

  if "${is_enabled_notification}"; then
    if [[ $dur_int -ge $NOTIFICATION_PERIOD_THRESHOLD ]]; then
      if type terminal-notifier 1>/dev/null 2>/dev/null; then
        # I prefer "Basso", "Frog", or "Pop" for notification sound
        # because I wouldn’t be surprised to hear these sounds suddenly.
        # But they may be too soft to notice.
        # In that case, "Default" or "Funk" may be good.
        terminal-notifier -message "Finished: $_tn_cmd" -sound $NOTIFICATION_SOUND -ignoreDnD

        # Tell the command is over by voice
        # Be careful the volume!
        # say "Finished: $_tn_cmd" -v Samantha
      else
        echo -en " \033[2m(terminal-notifier is not installed)\033[00m"
      fi

      echo -en " \033[2m(\033[3mecho '$_tn_cmd' >> $DOTPATH/NOTIFICATION_SKIP_COMMAND_LIST\033[00m \033[2mto disable notification for this command)\033[00m"
    fi
  else
    echo -en " \033[2m(notification is disabled for this command)\033[00m"
  fi
}

function __print_elapsed_time() {
  # Do not use colorecho because it is a bit late
  ## echo average time:      0.00843399999999999
  ## colorecho average time: 0.17544710000000002
  echo
  echo -en "elapsed time: \033[1m$dur_float\033[00m seconds"
}

function __postprocessing() {
  _tn_cmd=''

  echo
}
