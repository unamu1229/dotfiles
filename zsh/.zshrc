# ローカル専用設定　gitに含めたくない秘密情報や環境ごとに異なるPATHのような設定は ~/.zshrc.local に書く
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# $TERM xterm-ghostty がEC2がわからない問題、世界標準xterm-256colorに偽装する
alias ssh='TERM=xterm-256color ssh'

# autojump
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
## j コマンドを効かせる為に下記が必要
## brew でインストールした場合は下記の.zshrcへの記載の出力はないが、gitからcloneした場合はinstall時に記載されている
## https://qiita.com/d-dai/items/54f07aeac596bf81d644
autoload -Uz compinit && compinit -u

# starship
eval "$(starship init zsh)"

# autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# History search with arrow keys
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# fzf
fpath=(~/.zsh/functions ${fpath})

# autoload fzf functions
for widget_name in ~/.zsh/functions/*; do
  local function_name="${widget_name:t}"
  zle -N "${function_name}"
  autoload -Uz "${function_name}"
done

bindkey '^r'   fh
