#!/bin/sh

# raise error if this script is not executed in this directory
if [ ${0} != "setup.sh" ]; then
  echo "Fatal error: this script must be executed in dotfiles directory."
  echo "You need to change directory so you can execure this script by"
  echo "typing the following command.\n"
  echo "$ sh setup.sh\n"
  echo "Aborted."
  exit 1
fi

for path in $PWD/*
do
  if [ -f ${path} ]; then
    file=`basename ${path}`

    if [ -e ${HOME}/.${file} -a -e ${HOME}/.${file}.backup ]; then
      echo "Error: this script tried to rename ${HOME}/.${file} to ${HOME}/.${file}.backup not to overwrite the original config file, but ${HOME}/.${file}.backup already exists.\n"
      echo "This operation was aborted.\n"
      continue
    fi

    if [ -e ${HOME}/.${file} ]; then
      mv ${HOME}/.${file} ${HOME}/.${file}.backup
    fi
    ln -s ${path} ${HOME}/.${file}
  fi
done

if [ ! -e $HOME/.bash ]; then
  ln -s ${PWD}/bash $HOME/.bash
fi

if [ ! -e $HOME/.vim ]; then
  mkdir $HOME/.vim
fi

if [ ! -e $HOME/.vim/config ]; then
  ln -s $PWD/vim $HOME/.vim/config
fi

# unlink this script and load config files
unlink $HOME/.setup.sh
source $HOME/.bash_profile
