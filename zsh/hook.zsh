#!/usr/bin/env zsh

function __arm() {
  CURRENT_COMMAND="$1"
}

function __autols() {
  if [ -n "$AUTOLS_DIR" ] && [ "$AUTOLS_DIR" != "$PWD" ]; then
    store_directory_stack

    echo -e ""
    echo -e "\033[1;92mFILES AND DIRECTORIES:\033[00m"

    if [ "$(echo $OSTYPE | grep -c -e "^darwin")" -ne 1 ]; then
      ls --color=auto --literal
    elif type gls 1>/dev/null 2>/dev/null; then
      gls --color=auto --literal
    else
      ls -G
    fi
  fi

  AUTOLS_DIR="${PWD}"
}

function __git_auto_execute() {
  # Return if the current directory is not under the Git project
  if [ ! -e "$(git rev-parse --git-dir 2> /dev/null)" ]; then
    return
  fi

  # NOTE: The file name ".git-fetch-last-update" cannot be changeable easily
  #       because it should be written in gitignore_global
  _last_update_file="$(git rev-parse --show-toplevel)/.git-fetch-last-update"

  # Fetch, create a last update file, and return if a last update file does not exist
  if [ ! -f $_last_update_file ]; then
    __git_auto_fetch
    __git_deletable_branches
    (echo $EPOCHREALTIME > $_last_update_file) &

    return
  fi

  _git_fetch_duration=$(echo "scale=10; $EPOCHREALTIME - $(cat $_last_update_file)" | bc | sed 's/^\./0./' | sed 's/\.[0-9,]*$//g')

  if [ $_git_fetch_duration -ge $GIT_FETCH_PERIOD_THRESHOLD ]; then
    __git_auto_fetch
    __git_deletable_branches
    (echo $EPOCHREALTIME > $_last_update_file) &
  fi
}

function __git_auto_fetch() {
  (git fetch > /dev/null 2>&1) &
}

function __git_deletable_branches() {
  deletable_branches=$(git branch --merged | grep -v \* | grep -v "^\s*main\|master\|develop$")

  if [ "$deletable_branches" != "" ]; then
    echo "The following branches are deletable because they have been tracked on the remote repository already"
    echo
    echo "$deletable_branches"
    echo
    echo "To delete them, perform \"git delete-local-branches\""
  fi
}

function __unarm() {
  CURRENT_COMMAND=""
}
