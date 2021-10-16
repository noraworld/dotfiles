#!/usr/bin/env zsh

function __autols() {
  if [ -n "$AUTOLS_DIR" ] && [ "$AUTOLS_DIR" != "$PWD" ]; then
    store_directory_stack

    echo -e ""
    echo -e "\033[1;92mFILES AND DIRECTORIES:\033[00m"
    ls
  fi

  AUTOLS_DIR="${PWD}"
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
