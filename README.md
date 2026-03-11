# dotfiles

GNU Stow を使って管理する個人用 dotfiles リポジトリです。

このリポジトリでは以下を使って設定ファイルを管理します。

- Git — 設定のバージョン管理
- GNU Stow — シンボリックリンクの管理
- local設定ファイル — マシン固有設定や秘密情報の分離

dotfiles は `$HOME` とは別のディレクトリに置き、  
**symlink を使って HOME に展開**します。

---

# ディレクトリ構成

```
dotfiles
├ README.md
├ install.sh
│
├ zsh/
│   └ .zshrc

```

各ディレクトリは **Stow のパッケージ単位**になります。

(例)zshディレクトリの内容を `$HOME` に展開するには以下のコマンドを実行します。
```zsh
stow -t ~ zsh
```
`$HOME` に展開した後、zshのシンボリックリンクを削除した時
```zsh
stow -t ~ -D zsh
```

---

# ローカル設定

マシン固有の設定や秘密情報は **git 管理しないファイルに分離**します。

例

```
~/.zshrc.local
```

`.zshrc`

```zsh
# ローカル設定を読み込む
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
```

---

例: `.zshrc.local`

```zsh
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export AWS_PROFILE=dev
```

このファイルは **git 管理しません**。

---

# 設計方針

- dotfiles リポジトリは `$HOME` とは分離する
- symlink を使って HOME に展開する
- マシン固有設定は `.local` ファイルに分離する
- 新しい環境で簡単に再現できる構成にする