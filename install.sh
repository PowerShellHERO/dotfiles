#!/usr/bin/env bash

set -euo pipefail
sudo -v
cd ~

## Install 方法:
## -   このアドレスを `curl | bash`
## -   これを install.sh に保存して chmod 755 install -> run,
## -   この下を逐次実行

sudo apt update
sudo apt install -y sudo git curl cc

PATH="$HOME/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

# chezmoi
if ! command -v chezmoi &>/dev/null; then
  sh -c "$(curl -fsLS get.chezmoi.io)" -- -b ~/.local/bin
fi

chezmoi init https://github.com/PowerShellHERO/dotfiles.git
chezmoi apply

