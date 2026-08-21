
# KEYMAP

# alias もここか？　もしかして。

# Ctrl = "^" or "\C-"
# Alt  = "^[" or "\e"

bindkey "^u" beginning-of-line       # HOME
bindkey "^e" end-of-line             # END
bindkey "^d" backward-delete-char    # BS
# ^k / ^n -> :History_and_Completion # 上/下
bindkey "^h" backward-char           # 左
bindkey "^l" forward-char            # 右
bindkey "^z" undo                    # Undo

bindkey "^b" backward-word
bindkey "^f" forward-word

# :q  exit      -> "$ZDOTDIR/zsh-functions.zsh"
# ^a  copy-line -> "$ZDOTDIR/zsh-functions.zsh"
# ^v  edit-command-line {{{

export EDITOR=nvim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

# }}}

