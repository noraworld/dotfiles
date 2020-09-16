#!/bin/sh

# raise error if this script is not executed in this directory
if [ ${0} != "setup.sh" ]; then
  echo -e "FATAL: this script must be executed in dotfiles directory."
  echo -e "You need to change directories so you can execure this script by"
  echo -e "typing the following command."
  echo -e "=== EXECUTE BELOW ==="
  echo -e "$ bash setup.sh"
  echo -e "=== EXECUTE ABOVE ==="
  echo -e "Aborted."
  exit 1
fi

function link_file() {
  # if the filename that is about to link is
  # already exists and is a directory
  # or a file but not a link file
  # or a link file but another file linking, then
  if [ -d "${2}" ] || [ -f "${2}" ] && [ ! -L "${2}" ] || [ -L "${2}" ] && [ "`readlink \"${2}\"`" != "${1}" ]; then
    echo -e "\"${2}\" already exists. You need to rename or move \"${2}\" to another filename or directory."
    echo -e "Skipping.\n"
  # else if the filename is not created,
  # so this script has not been executed yet or
  # unlink these files, then
  elif [ ! -e "${2}" ]; then
    ln -s "${1}" "${2}"
  fi
}

function link_directory() {
  # if the filename that is about to link is
  # already exists and is a file
  # or a directory but not a link directory
  # or a link directory but another directory linking, then
  if [ -f "${2}" ] || [ -d "${2}" ] && [ ! -L "${2}" ] || [ -L "${2}" ] && [ "`readlink \"${2}\"`" != "${1}" ]; then
    echo -e "\"${2}\" already exists. You need to rename or move \"${2}\" to another filename or directory."
    echo -e "Skipping.\n"
  # else if the filename is not created,
  # so this script has not been executed yet or
  # unlink these directories, then
  elif [ ! -e "${2}" ]; then
    ln -s "${1}" "${2}"
  fi
}

function install_vim_bundle() {
  # install NeoBundle
  curl -LsS https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
  sh ./install.sh 1>/dev/null 2>/dev/null
  rm ./install.sh

  # install vim-plug
  if [ ! -e ~/.vim/autoload ]; then
    mkdir -p ~/.vim/autoload
  fi
  curl -LsS https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > ~/.vim/autoload/plug.vim

  # install Vundle
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 1>/dev/null 2>/dev/null
}

function copy_gitconfig_local() {
  if [ ! -f $PWD/core/gitconfig.local ]; then
    cp $PWD/core/gitconfig.local.sample $PWD/core/gitconfig.local
  fi
}

function check_git_version() {
  # if Git version is 2.12.1, git_version is assigned to 2, and git_sub_version is assigned to 12.
  git_version=`git --version | egrep -o '[0-9]+(\.[0-9]+)?' | head -1 | egrep -o '^[0-9]*' | head -1`
  git_sub_version=`git --version | egrep -o '[0-9]+(\.[0-9]+)?' | head -1 | egrep -o '[0-9]*$' | head -1`
  recommended_git_version=2
  recommended_git_sub_version=8

  # if Git version is less than recommended Git version
  if [ "${git_version}" -lt "${recommended_git_version}" ] || ( [ "${git_version}" -eq "${recommended_git_version}" ] && [ "${git_sub_version}" -lt "${recommended_git_sub_version}" ] ); then
    echo -e "WARNING: Your Git version is less than ${recommended_git_version}.${recommended_git_sub_version}."
    echo -e "It is recommended to use Git ${recommended_git_version}.${recommended_git_sub_version} or higher.\n"
  fi
}

function make_dotfiles_path() {
  if [ ! -e $HOME/.dotpath ]; then
    touch $HOME/.dotpath
  fi

  echo -e "DOTPATH=$PWD" > $HOME/.dotpath
}

# copy gitconfig.local.sample to gitconfig.local
copy_gitconfig_local

# set DOTPATH
make_dotfiles_path

# link all files in core/ directory
for src_path in $PWD/core/*
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

# create VS Code preference directory if not exists
# TODO: this depends on macOS, so support for Linux
if [ ! -e $HOME/Library/Application\ Support/Code/User ]; then
  mkdir -p $HOME/Library/Application\ Support/Code/User
fi

# link all files in bash, vim, git_template and bin directory
link_directory ${PWD}/bash       $HOME/.bash
link_directory $PWD/vim          $HOME/.vim/config
link_directory $PWD/git_template $HOME/.git_template
link_directory $PWD/bin/src      $HOME/.bin
link_directory $PWD/config       $HOME/.config

# link VS Code preferences
# TODO: this depends on macOS, so support for Linux
for src_path in ${PWD}/vscode/*
do
  if [ -f ${src_path} ]; then
    dst_path=$HOME/Library/Application\ Support/Code/User/`basename ${src_path}`
    link_file "${src_path}" "${dst_path}"
  fi
done

# Automator workflows
if [ ! -e $HOME/Library/Workflows ]; then
  link_directory $PWD/macos/Workflows $HOME/Library/Workflows
elif [ ! -L $HOME/Library/Workflows ] && [[ ${OSTYPE} =~ ^darwin.+ ]]; then
  echo "WARNING: Automator workflows already exist. Move them to another location."
fi

# unlink unnecessary files
unlink $HOME/.gitconfig.local.sample

# install the Vim plugins
install_vim_bundle

# check Git version
check_git_version

echo -e "Done! Check warnings if they exist."
exit 0
