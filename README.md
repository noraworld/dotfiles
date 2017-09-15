# dotfiles
This repository includes the following configuration files.

* Bash
* Vim
* Emacs

The Emacs configuration file is probably no longer updated, sorry x(

## How to setup
All you have to do is run the setup script.

**NOTICE:** You need to change directories so you can run it in dotfiles directory.

```bash
$ cd path/to/dotfiles
$ sh setup.sh
$ source ~/.bash_profile
```

Done!

**NOTE:** If you use new Ubuntu server, `curl` command might not be installed.

```bash
curl: command not found
```

You have to install `curl` if the above message appears while running `setup.sh`. Then run `setup.sh` again.

```bash
$ sudo apt -y install curl
```

## Dependencies
The following is some libraries used in this dotfiles. These dependencies will be fixed by preparing provisioning in the future...

* coreutils (`brew install coreutils`)
* binutils (`brew install binutils`)
* findutils (`brew install findutils`)
* peco (different between platforms)
* git (git-completion)
* ghq (different between platforms)
