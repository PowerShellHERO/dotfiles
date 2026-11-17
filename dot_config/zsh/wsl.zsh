
# WSL : for Windows Subsystem for Linux

# WSL じゃないなら return
[[ -z "$WSL_DISTRO_NAME" ]] && return

alias start=explorer.exe

# '^a' copy-line {{{

function copy-line() {
    echo -n $BUFFER | wl-copy
    BUFFER=''
    zle reset-prompt
}

# function copy-line() {
#     echo -n $BUFFER | iconv -f utf-8 -t utf-16le | sed '1s/^\xFF\xFE//' | ~/bin/clip.exe
#     BUFFER=''
#     zle reset-prompt
# }

zle -N copy-line
bindkey '^a' copy-line # プロンプト入力中の文字列をコピー

# }}}


