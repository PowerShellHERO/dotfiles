
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
    if [[ ! -n "$TMUX" ]]; then
        warn "tmux isn't running"
        return 0
    fi

    tmux kill-window -a
}

## }}}
## `:o`   : only a remains vim window {{{

# kill-all except vim
# -   vim が動いている window に移動する。
# -   vim が動いてない window をできるだけ削除。
only_a_remains_vim_window() {
    if [[ ! -n "$TMUX" ]]; then
        warn "tmux isn't running"
        return 0
    fi

    local is_vim_running
    tmux list-panes -s -F '#{window_id} #{pane_current_command}' | \
         grep vim | tail -n 1 | read is_vim_running

    tmux select-window $is_vim_running

    if test $is_vim_running ; then
        tmux list-panes -s -F '#{window_id} #{pane_current_command}' | \
            grep -v vim | \
            cut -d ' ' -f1 | \
            xargs -I{} tmux kill-window -t {}
    else
        tmux kill-window -a
    fi
}

# only_a_remains_vim_window() {
#     # print window id and current command in this sessoin
#     # -> filter commands with not include vim (grep -v = inverse)
#     # -> cut for window_id
#     # -> tmux kill-window
#     if [[ -n "$TMUX" ]]; then
#         tmux list-panes -s -F '#{window_id} #{pane_current_command}' | \
#         grep -v vim | \
#         cut -d ' ' -f1 | \
#         xargs -I{} tmux kill-window -t {}
#     fi
# }
alias :o=only_a_remains_vim_window

## }}}
## ppath() : show $PATH {{{
ppath() {
    print -l $path
    # echo -e ${PATH//:/\n}
}
## }}}

