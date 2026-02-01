#!/usr/bin/env bash
#
# for ubuntu
# 
# curl -fsSL https://raw.githubusercontent.com/PowerShellHERO/dotfiles/refs/heads/main/00_apt_core.sh | sudo bash
#

set -e

# 管理者権限が必要な作業
## sudo で実行されているかチェック
if [ "$EUID" -ne 0 ]; then
    echo "警告: /opt への展開には管理者権限が必要。"
    echo "sudo をつけて再実行してください。"
    echo "Usage:"
    echo "curl -fsSL https://raw.githubusercontent.com/PowerShellHERO/dotfiles/refs/heads/main/00_apt_core.sh | sudo bash"
    exit 1
fi


apt update && apt upgrade -y
apt install git python3 zsh -y

## mkdir -p ~/download && cd ~/download
## curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
## 
## rm -rf /opt/nvim-linux-x86_64
## tar -C /opt -xzf nvim-linux-x86_64.tar.gz
## ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

echo " --- complete ---"
echo "apt update, core app installation"
echo "Next, clone the dotfiles and run install.sh"
echo "Don't forget to grant chmod 755."


