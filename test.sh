#!/usr/bin/env bash

set -e

# REPOSITORY = https://github.com/PowerShellHERO/dotfiles.git

# 管理者権限が必要な作業
## スクリプトが sudo で実行されているかチェック
if [ "$EUID" -ne 0 ]; then
  echo "警告: /opt への展開には管理者権限が必要。"
  echo "sudo をつけて再実行してください。"
  exit 1
fi

if [ ! -d ~/dotfiles ]; then
   git clone https://github.com/PowerShellHERO/dotfiles.git
   echo "Downlaod dotfiles"
fi

