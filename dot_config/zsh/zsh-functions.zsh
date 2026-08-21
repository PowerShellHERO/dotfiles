
# ZSH-FUNCTIONS: A set of essential functions

# echo "reloaded: 00 zsh-function"

## Show Info: colored print {{{

info()    { printf '\e[1;34m[INFO]\e[0m  %s\n' "$*"; }
success() { printf '\e[1;32m[OK]\e[0m    %s\n' "$*"; }
warn()    { printf '\e[1;33m[WARN]\e[0m  %s\n' "$*"; }
die()     { printf '\e[1;31m[ERR]\e[0m   %s\n' "$*" >&2; exit 1; }

### }}}
## Edit and Reload: co / so:   {{{

co() { # edit zshrc
    nvim $ZDOTDIR/.zshrc
}

so() { # reload zshrc
    source $ZDOTDIR/.zshrc
    success "reload .zshrc"
}

### }}}
## Source file / Install plugin {{{

export ZSH_PLUGINS="$ZDOTDIR"/plugins

zsh_add_file() {
    [ -f "$1" ] && source "$1"
    # [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}
# `zsh_add_file $ZDOTDIR/myplug.zsh` と書くほうがいいかも
# gf も使えるし

zsh_add_plugin() {
    local repo="$1"
    local plug_name=$(echo "$repo" | cut -d "/" -f 2)
    local plug_dir="$ZSH_PLUGINS/$plug_name"

    [ -d "$plug_dir" ] || git clone "https://github.com/$repo" "$plug_dir"

    # だいたいどっちか
    zsh_add_file "$plug_dir/$plug_name.zsh"
    zsh_add_file "$plug_dir/$plug_name/$plug_name.plugin.zsh"
}

# test
# rm -rf ~/.config/zsh/plugins/zsh-autosuggestions/
# zsh_add_plugin "zsh-users/zsh-autosuggestions"

## }}}
## `:q`   : Semicolon => Colon {{{

function insert-semicolon() {
    if [[ -z "$LBUFFER" ]]; then
        LBUFFER+=":"
    else
        LBUFFER+=";"
    fi
}
zle -N insert-semicolon
bindkey ";" insert-semicolon
alias :q=exit\ 0

## }}}
## `:only`: tmux kill-window -a {{{

:only() {
    if [[ -n "$TMUX" ]]; then
        tmux kill-window -a
    fi
}

## }}}
## `:o`   : only a remains vim window {{{

# kill-all except vim

only_a_remains_vim_window() {
    # print window id and current command in this sessoin
    # -> filter commands with not include vim (grep -v = inverse)
    # -> cut for window_id
    # -> tmux kill-window
    if [[ -n "$TMUX" ]]; then
        tmux list-panes -s -F '#{window_id} #{pane_current_command}' | \
        grep -v vim | \
        cut -d ' ' -f1 | \
        xargs -I{} tmux kill-window -t {}
    fi
}
alias :o=only_a_remains_vim_window

## }}}
## ppath() : show $PATH {{{
ppath() {
    print -l $path
    # echo -e ${PATH//:/\n}
}
## }}}

