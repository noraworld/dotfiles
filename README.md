# dotfiles
This repository supports the following configuration files.

| Type             | Fully supported | Partially supported      | No longer supported                                            |
| ---------------- | :-------------: | :----------------------: | :------------------------------------------------------------: |
| Shells           | Zsh             |                          |                                                                |
| Editors          | Vim<br>VS Code  |                          | Emacs<br>[Sublime Text 3](https://github.com/noraworld/sublrc) |
| OS               | macOS           | Windows<br>Ubuntu Server |                                                                |
| Package managers | Homebrew<br>APT |                          |                                                                |

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

```shell
cd dotfiles
./setup

asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf install ruby $(cat .ruby-version)
gem install bundler
bundle install

asdf plugin-add python
asdf install python $(cat .python-version)
pip install pipenv
asdf reshim python
pipenv install --target python_modules
asdf reshim python

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs $(cat .node-version)
npm install
```

**IMPORTANT NOTE 1**: You should install Vim plugins and quit it when it’s started up while executing a setup script.

**IMPORTANT NOTE 2**: Node packages to be used globally are installed locally in `dotfiles/node_modules` and called from `dotfiles/node_modules/.bin` globally because npm cannot install packages globally from `package.json` (`npm install -g` is invalid). The option `-g` should not be added when new package will be installed because the package will not be added to `package.json`.

## Dependencies
This dotfiles depends on the following.

| Dependency | Version    | Reason why this version needed                                      |
|------------|------------|---------------------------------------------------------------------|
| Git        | `>= 2.8`   | Using `useConfigOnly` in `.gitconfig`                               |
| Ruby       | `>= 2.5.1` | No guarantee self-making commands work fine under the lower version |
| Homebrew   | `any`      | n/a                                                                 |

## Others
* It is recommended to run the setup script every time new files are added.
* If you want to add your additional Git configuration, just add them to `gitconfig.local`.
