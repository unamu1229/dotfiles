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
├ ghostty/
│   └ .config/
│       └ ghostty/
│           └ config.ghostty
│
├ zsh/
│   └ .zshrc

```

各ディレクトリは **Stow のパッケージ単位**になります。

(例)zshディレクトリの内容を `$HOME` に展開するには以下のコマンドを実行します。
```zsh
stow -t ~ zsh
```
Ghostty の設定ファイルを XDG 形式で展開するには以下のコマンドを実行します。
```zsh
stow -t ~ ghostty
```
`$HOME` に展開した後、zshのシンボリックリンクを削除した時
```zsh
stow -t ~ -D zsh
```
Ghostty のシンボリックリンクを削除する場合
```zsh
stow -t ~ -D ghostty
```

まとめて展開する場合
```zsh
stow -t ~ zsh ghostty
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

Ghostty の設定は以下の `XDG` パスを管理対象にしています。

```text
~/.config/ghostty/config.ghostty
```

`Ghostty 1.3.1` 同梱ドキュメントでは、macOS では
`~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`
が `XDG` パスより優先されます。

そのため `install.sh` では、以下の既存ファイルがある場合に
`*.bak.YYYYMMDDHHMMSS` としてバックアップしてから `Stow` でリンク化します。

```text
~/Library/Application Support/com.mitchellh.ghostty/config.ghostty
~/Library/Application Support/com.mitchellh.ghostty/config
~/.config/ghostty/config.ghostty
```

---

# 設計方針

- dotfiles リポジトリは `$HOME` とは分離する
- symlink を使って HOME に展開する
- マシン固有設定は `.local` ファイルに分離する
- 新しい環境で簡単に再現できる構成にする