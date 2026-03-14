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
mkdir -p "$XDG_CONFIG_HOME/zsh"
mkdir -p "$XDG_CONFIG_HOME/git"
mkdir -p "$XDG_DATA_HOME/fonts"
mkdir -p "$XDG_STATE_HOME/zsh"
mkdir -p "$XDG_CACHE_HOME/zsh"
mkdir -p "$HOME/.local/bin"
mkdir -p $ZSH_PLUGINS

echo "--- run_once_mkdir DONE ---"

