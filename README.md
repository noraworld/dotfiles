# dotfiles
This repository supports the following configuration files.

| Type             | Fully supported | Partially supported | No longer supported                                            |
|------------------|:---------------:|:-------------------:|:--------------------------------------------------------------:|
| Shells           | Bash            |                     |                                                                |
| Editors          | Vim<br>VS Code  |                     | Emacs<br>[Sublime Text 3](https://github.com/noraworld/sublrc) |
| SCM              | Git             |                     |                                                                |
| OS               | macOS           | Windows<br>Linux    |                                                                |
| Package managers | Homebrew        |                     |                                                                |

<dl>
  <dt>Fully supported</dt>
  <dd>All configuration works fine. New configuration will be added, and existing configuration will be fixed if bugs exist.</dd>
  <dt>Partially supported</dt>
  <dd>Some configuration may not work properly. For example, due to the lack of commands. These problems will be fixed, but it may take a while.</dd>
  <dt>No longer supported</dt>
  <dd>The configuration files will not be supported.</dd>
</dl>

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
* `git (>= 2.8)`

It is recommended to install Git `2.8` or higher.

## How to setup
Run the setup script. You need to change directories so you can run it in dotfiles directory.

```bash
$ cd path/to/dotfiles
$ bash setup.sh
$ source ~/.bash_profile
$ git refresh
$ bundle install
```

That’s all!

## Dependencies
This dotfiles depends on the following.

* Bash
* Git version 2.8 or higher
* Ruby (version 2.5.1 or higher is recommended)
* Homebrew

## Dependencies
The following libraries are used in this dotfiles. These dependencies will be fixed by preparing provisioning in the future...

* coreutils (`brew install coreutils`)
* binutils (`brew install binutils`)
* findutils (`brew install findutils`)
* peco (different between platforms)
* git-completion (`sudo git clone https://github.com/git/git /usr/local/git`)
* ghq (different between platforms)
* source-highlight (`brew install source-highlight`)
* direnv (`brew install direnv`)
* getopt (`brew install gnu-getopt`)
* sed (`brew install gnu-sed`)

## Others
* It is recommended to run the setup script every time new files are added.
* If you want to add your additional Git configuration, just add them to `gitconfig.local`.
