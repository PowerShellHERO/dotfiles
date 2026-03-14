#!/bin/bash

# 1. XDG 基本変数の定義
# すでに環境変数が設定されている場合はそれを使う。
export XDG_CONFIG_HOME="$HOME"/.config
export XDG_CACHE_HOME="$HOME"/.cache
export XDG_DATA_HOME="$HOME"/.local/share
export XDG_STATE_HOME="$HOME"/.local/state

export HISTFILE="$XDG_STATE_HOME"/zsh/history
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export ZSH_PLUGINS="$ZDOTDIR"/plugins

# mkdir
mkdir "$XDG_CONFIG_HOME/zsh"
mkdir "$XDG_CONFIG_HOME/git"
mkdir "$XDG_DATA_HOME/fonts"
mkdir "$XDG_STATE_HOME/zsh"
mkdir "$XDG_CACHE_HOME/zsh"
mkdir "$HOME/.local/bin"
mkdir $ZSH_PLUGINS

echo "--- run_once_mkdir DONE ---"

