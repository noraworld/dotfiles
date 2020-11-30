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
You should move the original dotfiles to somewhere else if they exist. The target dotfiles are all files in [`core/`](core/) directory.

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
$ brew bundle install --global --no-lock
$ source ~/.bash_profile
$ vi # install neobundle plugin and exit

# Install **env
$ anyenv install rbenv
$ anyenv install pyenv

# Install Ruby
$ rbenv install $(cat .ruby-version)
$ gem install bundler -v '1.16.5'
$ bundle install

# Install Python
$ brew discard binutils && pyenv install $(cat .python-version) && brew get binutils
$ pyenv global $(cat .python-version)
$ pip install pipenv
$ pipenv install --system
```

That’s all!

**NOTE**: If you face a problem that most commands show `Killed: 9` and do not work after running `brew bundle install --global`, just type `exit` to exit a shell and reopen it again. The terminal process probably [terminates with exit code 137](https://code.visualstudio.com/docs/supporting/troubleshoot-terminal-launch), but it can be ignored. This causes when bash is updated.

## Dependencies
This dotfiles depends on the following.

| Dependency | Version    | Reason why this version needed                                      |
|------------|------------|---------------------------------------------------------------------|
| Bash       | `>= 5.0`   | Using `$EPOCHREALTIME` in `.bashrc`                                 |
| Git        | `>= 2.8`   | Using `useConfigOnly` in `.gitconfig`                               |
| Ruby       | `>= 2.5.1` | No guarantee self-making commands work fine under the lower version |
| Homebrew   | `any`      | n/a                                                                 |

## Others
* It is recommended to run the setup script every time new files are added.
* If you want to add your additional Git configuration, just add them to `gitconfig.local`.
