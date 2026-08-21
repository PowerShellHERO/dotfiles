# chezmoi-lab

dotfiles の自動インストールが正常に動作するかを確認するための、使い捨て Docker 環境。

## Build

```sh
docker build -t chezmoi-lab ~/docker/chezmoi-lab
```

## Run

```sh
docker run -it --rm chezmoi-lab
```

コンテナ内で以下を実行する。

```sh
curl -fsSL https://raw.githubusercontent.com/PowerShellHERO/dotfiles/refs/heads/main/install.sh | bash
```

インストールが完了したら zsh を起動する。

```sh
zsh
```

`--rm` を指定しているため、コンテナ終了時に環境は自動的に削除される。

## Purpose

この環境は、dotfiles のインストールスクリプトをクリーンな環境で実行し、

* 必要なパッケージが正しくインストールされるか
* chezmoi による dotfiles の適用が成功するか
* zsh の設定が正常に読み込まれるか

を確認するために使用する。

