#!/usr/bin/env bash

set -e

brew install stow

brew install fzf

brew install autojump

backup_and_remove_if_exists() {
  local target_path="$1"

  if [ -L "$target_path" ]; then
    rm "$target_path"
  elif [ -e "$target_path" ]; then
    local backup_path="$target_path.bak.$(date +%Y%m%d%H%M%S)"
    cp "$target_path" "$backup_path"
    rm "$target_path"
  fi
}

ghostty_xdg_config_target="$HOME/.config/ghostty/config.ghostty"

# macOS では Application Support 側が XDG より優先されるため、
# 旧形式の設定が残っている場合は退避してから XDG 形式へ移行する。
backup_and_remove_if_exists "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
backup_and_remove_if_exists "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
backup_and_remove_if_exists "$ghostty_xdg_config_target"

stow -t ~ zsh ghostty

brew install zsh-autosuggestions

brew install starship
