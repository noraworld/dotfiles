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

function link_file() {
  # if the filename that is about to link is
  # already exists and is a directory
  # or a file but not a link file
  # or a link file but another file linking, then
  if [ -d ${2} ] || [ -f ${2} ] && [ ! -L ${2} ] || [ -L ${2} ] && [ "`readlink ${2}`" != "${1}" ]; then
    echo "${2} already exists. You need to rename or move ${2} to another filename or directory."
    echo "Skipping.\n"
  # else if the filename is not created,
  # so this script has not been executed yet or
  # unlink these files, then
  elif [ ! -e ${2} ]; then
    ln -s ${1} ${2}
  fi
}

function link_directory() {
  # if the filename that is about to link is
  # already exists and is a file
  # or a directory but not a link directory
  # or a link directory but another directory linking, then
  if [ -f ${2} ] || [ -d ${2} ] && [ ! -L ${2} ] || [ -L ${2} ] && [ "`readlink ${2}`" != "${1}" ]; then
    echo "${2} already exists. You need to rename or move ${2} to another filename or directory."
    echo "Skipping.\n"
  # else if the filename is not created,
  # so this script has not been executed yet or
  # unlink these directories, then
  elif [ ! -e ${2} ]; then
    ln -s ${1} ${2}
  fi
}

# link all files in current directory
for src_path in $PWD/*
do
  if [ -f ${src_path} ]; then
    dst_path=${HOME}/.`basename ${src_path}`
    link_file ${src_path} ${dst_path}
  fi
done

# create .vim/ directory if not exists
if [ ! -e $HOME/.vim ]; then
  mkdir $HOME/.vim
fi

# link all files in bash/ and vim/ directory
link_directory ${PWD}/bash $HOME/.bash
link_directory $PWD/vim    $HOME/.vim/config

# unlink this script
unlink $HOME/.setup.sh
