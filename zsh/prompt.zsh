#!/usr/bin/env zsh

ssh_ps1() {
  if [ -f /proc/$PPID/cmdline ]; then
    if [ "$(command cut -d : -f1 < "/proc/$PPID/cmdline")" = "sshd" ] && [[ $- == *i* ]]; then
      echo "\033[1;96m[SSH] \033[00m"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

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

caffeine_count() {
  echo -e "\033[38;05;172m$(ps aux | grep caffeinate | grep -cv grep)\033[00m"
}

get_prompt_state() {
  PROMPT_STATE="$(recording_prompt) with ☕️ $(caffeine_count) with 🌡  $(temperature)"
}

get_prompt_state
