# dotfiles
This repository includes the following configuration files.

* Bash
* Vim
* Emacs
* Git

The Emacs configuration file is probably no longer updated.

## Before the setup
You should move the following original dotfiles to somewhere else if they exist.

* `.bash_profile`
* `.bashrc`
* `.emacs.el`
* `.inputrc`
* `.vimrc`
* `.dir_colors`
* `.gitconfig`
* `.gitconfig.local`
* `.gitignore_global`

The following commands are used during the setup. Please install them.

* `curl`
* `git`

It is recommended to install Git `2.8` or higher.

## How to setup
Copy `gitconfig.local.sample` to `gitconfig.local`, and edit `gitconfig.local` to your own configurations.

```bash
$ cp gitconfig.local.sample gitconfig.local
# Edit gitconfig.local
```

Then please run the setup script. You need to change directories so you can run it in dotfiles directory.

```bash
$ cd path/to/dotfiles
$ bash setup.sh
$ source ~/.bash_profile
```

Done!

## Dependencies
The following libraries are used in this dotfiles. These dependencies will be fixed by preparing provisioning in the future...

* coreutils (`brew install coreutils`)
* binutils (`brew install binutils`)
* findutils (`brew install findutils`)
* peco (different between platforms)
* git (git-completion)
* ghq (different between platforms)

## Others
It is recommended to run the setup script every time new files are added.
