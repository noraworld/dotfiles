# bin
A set of the self-making commands.

## How to setup
1. Cloning this repository and run the setup script

```sh
$ git clone https://github.com/noraworld/bin
$ cd bin
$ bash setup.sh
```

2. Download a path setup script and run it

```sh
$ git clone https://github.com/noraworld/dotfiles/blob/master/bash/bin.bash
$ source dotfiles/bash/bin.bash
```

3. Make them executable when sudo mode (Optional)

```sh
$ sudo visudo
```

```diff
# Add `/home/username/.bin` path to the end of line of `secure_path`.
# Replace `username` with your own username.
- Defaults    secure_path = /usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
+ Defaults    secure_path = /usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/home/username/.bin
```

## Other
If you want to install additional command line tools like `peco` from other projects, you can put them to `src/local`.
