#!/usr/bin/env bash

sudo -v

sudo apt install -y \
    locales \
    python3 \
    tmux


# locales
locale-gen en_US.UTF-8
update-locale LANG=en_US.UTF-8

# nvim {{{
mkdir -p ~/download && cd ~/download
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
cd
# }}}

# zsh plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions

## Starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

echo ""
echo "--- run_once: apt install DONE ---"
echo ""

## 'source zshrc' は手動でするしかないかも？
## zsh 用の script に分けてもダメだった。

