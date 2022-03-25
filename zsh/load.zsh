#!/usr/bin/env zsh

# Set colors to ls command
eval $(dircolors -b ~/.dir_colors)

if type starship 1>/dev/null 2>/dev/null; then
  eval "$(starship init zsh)"
fi

# Use direnv
# It should appear even after shell extensions that manipulate the prompt like git-prompt
if type direnv 1>/dev/null 2>/dev/null; then
  eval "$(direnv hook zsh)"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node
### End of Zinit's installer chunk

zinit light zdharma/history-search-multi-word
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light asdf-vm/asdf
# TODO: Uninstall Starship from both Mac and Raspberry Pi, and manage it with Zinit
#       Because on Ubuntu it cannot be installed via apt
if [ "$(uname -i)" = "aarch64" ] && [ "$OSTYPE" =~ "linux-gnu" ]; then
  zinit ice from"gh-r" as"program" bpick"*aarch64-unknown-linux-gnu*" pick"rg"
  zinit light microsoft/ripgrep-prebuilt
fi
zinit blockf light-mode as"program" from"gh-r" for \
    atload'eval "$(zabrze init --bind-keys)"' \
    Ryooooooga/zabrze

autoload -Uz compinit && compinit
