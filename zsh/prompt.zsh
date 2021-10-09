#!/usr/bin/env zsh

recording_prompt() {
  case "${OSTYPE}" in
    darwin*)
      if [[ "$(ps -e -o pid,command | grep -E "^\s{0,}$PPID" | grep -v grep)" =~ "script" ]]; then
        echo "\033[1;92m🔴 RECORDING\033[00m"
      elif [[ "$(ps -e -o pid,command | grep -E "^\s{0,}$PPID" | grep -v grep)" =~ "login" ]]; then
        echo "\033[1;91m❌ NOT RECORDING!!!\033[00m"
      else
        echo "\033[1;93m❓ UNKNOWN\033[00m"
      fi
    ;;
    linux*)
      : # TODO (perhaps same as macOS, but not confirmed yet)
      echo "\033[1;91m❌ NOT SUPPORTED\033[00m"
    ;;
  esac
}
