#!/usr/bin/env zsh

# Refer to https://bearmini.hatenablog.com/entry/2016/02/16/222057. Thanks a lot!

_tn_cmd=''

function __set_preexec_variable() {
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

function __autorun() {
  if [[ -n $AUTORUN_DIR ]] && [[ $AUTORUN_DIR != $PWD ]]; then
    store_directory_stack

    echo -e ""
    echo -e "\033[1;92mFILES AND DIRECTORIES:\033[00m"
    ls
  fi

  AUTORUN_DIR="${PWD}"
}

function __git_autofetch() {
  # Return if the current directory is not under the Git project
  if [ ! -e "$(git rev-parse --git-dir 2> /dev/null)" ]; then
    return
  fi

  # NOTE: The file name ".git-fetch-last-update" cannot be changeable easily
  #       because it should be written in gitignore_global
  _last_update_file="$(git rev-parse --show-toplevel)/.git-fetch-last-update"

  # Fetch, create a last update file, and return if a last update file does not exist
  if [ ! -f $_last_update_file ]; then
    (git fetch   > /dev/null 2>&1 &)
    (git refresh > /dev/null 2>&1 &) # on the way
    (echo $EPOCHREALTIME > $_last_update_file &)

    return
  fi

  _git_fetch_duration=$(echo "scale=10; $EPOCHREALTIME - $(cat $_last_update_file)" | bc | sed 's/^\./0./' | sed 's/\.[0-9,]*$//g')

  if [ $_git_fetch_duration -ge $GIT_FETCH_PERIOD_THRESHOLD ]; then
    (git fetch   > /dev/null 2>&1 &)
    (git refresh > /dev/null 2>&1 &) # on the way
    (echo $EPOCHREALTIME > $_last_update_file &)
  fi
}

function __postprocessing() {
  _tn_cmd=''
}
