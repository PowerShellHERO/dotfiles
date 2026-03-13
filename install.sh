#!/usr/bin/env bash

set -euo pipefail
sudo -v

## Install 方法:
## -   このアドレスを `curl | bash`
## -   これを install.sh に保存して chmod 755 install -> run,
## -   この下を逐次実行

sudo apt update
sudo apt install -y sudo git curl

sh -c "$(curl -fsLS get.chezmoi.io)"

chezmoi init https://github.com/PowerShellHERO/dotfiles.git
chezmoi apply

