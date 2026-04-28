#!/usr/bin/env bash

set -e

dotfiles_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ghostty_repo_config="$dotfiles_root/ghostty/.config/ghostty/config.ghostty"
ghostty_xdg_config_target="$HOME/.config/ghostty/config.ghostty"
nano_repo_config="$dotfiles_root/nano/.nanorc"
nano_config_target="$HOME/.nanorc"

brew install stow

brew install fzf

brew install autojump

brew install nano

backup_and_remove_if_exists() {
  local target_path="$1"

  if [ -e "$target_path" ] || [ -L "$target_path" ]; then
    local backup_path="$target_path.bak.$(date +%Y%m%d%H%M%S)"
    mv "$target_path" "$backup_path"
  fi
}

backup_and_remove_if_unmanaged() {
  local target_path="$1"
  local managed_path="$2"

  if [ ! -e "$target_path" ] && [ ! -L "$target_path" ]; then
    return
  fi

  if [ -e "$managed_path" ] && [ "$target_path" -ef "$managed_path" ]; then
    return
  fi

  backup_and_remove_if_exists "$target_path"
}

# macOS では Application Support 側が XDG より優先されるため、
# 旧形式の設定が残っている場合は退避してから XDG 形式へ移行する。
backup_and_remove_if_exists "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
backup_and_remove_if_exists "$HOME/Library/Application Support/com.mitchellh.ghostty/config"
backup_and_remove_if_unmanaged "$ghostty_xdg_config_target" "$ghostty_repo_config"
backup_and_remove_if_unmanaged "$nano_config_target" "$nano_repo_config"

stow -R -t ~ zsh ghostty nano

brew install zsh-autosuggestions

brew install starship
