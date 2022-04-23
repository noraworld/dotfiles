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
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit light zdharma/history-search-multi-word
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light asdf-vm/asdf
# TODO: Uninstall Starship from both Mac and Raspberry Pi, and manage it with Zinit
#       Because on Ubuntu it cannot be installed via apt
if [ "$OSTYPE" =~ "linux-gnu" ] && [ "$(uname -i)" = "aarch64" ]; then
  zinit ice from"gh-r" as"program" bpick"*aarch64-unknown-linux-gnu*" pick"rg"
  zinit light microsoft/ripgrep-prebuilt
fi
zinit blockf light-mode as"program" from"gh-r" for \
    atload'eval "$(zabrze init --bind-keys)"' \
    Ryooooooga/zabrze
zinit ice as"program" cp"whatshell.sh -> whatshell" pick"whatshell"
zinit snippet https://www.in-ulm.de/~mascheck/various/whatshell/whatshell.sh

autoload -Uz compinit && compinit

# It should be after compinit
zinit light Aloxaf/fzf-tab
