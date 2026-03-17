#!/usr/bin/env bash

set -e

brew install stow

brew install fzf

brew install autojump

stow -t ~ zsh

brew install zsh-autosuggestions

brew install starship
