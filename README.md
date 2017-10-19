# dotfiles
This repository includes the following configuration files.

* Bash
* Vim
* Emacs

The Emacs configuration file is probably no longer updated.

## How to setup
Before running the setup script, you should move the following original dotfiles to somewhere else if they exist.

* .bash_profile
* .bashrc
* .emacs.el
* .inputrc
* .vimrc

All you have to do is run the setup script. See also the troubleshootings if no work well. You need to change directories so you can run it in dotfiles directory.

```bash
$ cd path/to/dotfiles
$ sh setup.sh
$ source ~/.bash_profile
```

Done!

## Troubleshootings
### A problem with curl command not found
If you use new Ubuntu server, `curl` might not be installed.

```bash
curl: command not found
```

You have to install `curl` if the above message appears while running `setup.sh`. Then run `setup.sh` again.

```bash
$ sudo apt -y install curl
```

### A problem with syntax errors
If you are faced with some syntax errors while running `setup.sh`, try using `bash` instead of `sh`.

```bash
$ bash setup.sh
```

## Dependencies
The following libraries are used in this dotfiles. These dependencies will be fixed by preparing provisioning in the future...

* coreutils (`brew install coreutils`)
* binutils (`brew install binutils`)
* findutils (`brew install findutils`)
* peco (different between platforms)
* git (git-completion)
* ghq (different between platforms)
