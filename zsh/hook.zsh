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

function __set_precmd_variable() {
  now=`echo $EPOCHREALTIME`
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
  if [ -e "$(git rev-parse --git-dir 2> /dev/null)" ]; then
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

function __postprocessing() {
  _tn_cmd=''
}
