
# Scratch
# TOC:
# -   :chezmoi
# -   :Alias
# -   :History_and_Completion
# -   :Git
# -   :Util

### Bash Renaissance {{{

# help command
function h() {
    # bash -c "help '$1'" だと h '((' などが展開されないため
    bash -c 'help -- "$@"' -- "$@"
}

# }}}

## :chezmoi {{{

dotstatus() {
    # get one modified file, except 'run_script.sh'
    # exclude run_script (grep -v '^ R')
    local fn
    chezmoi status | grep -v '^ R' | head -n 1 | sed 's/.../~\//' | read fn
    echo $fn
}

# chezmoi add -> git add -> git commit
dotpush() {
    local fn=$(dotstatus)
    [[ "$fn" == "" ]] && success "not modified" && return 0

    chezmoi diff $fn --reverse  | tail -n +6 | bat -l diff
    echo "Add and commit? [Enter to continue / q to quit]: "
    read -k ans # -k: read first char
    [[ "$ans" == "q" ]] && echo 'uit!' && return 0

    chezmoi add $fn
    cd $(chezmoi source-path)
    git add -A && git commit
    cd -
}

# cd $dotfiles with popup window
_popup_dotfilesdir() {
    tmux display-popup \
        -w 80% \
        -h 80% \
        -E "cd "$(chezmoi source-path)" && $SHELL"
    }

## cd chezmoi
dot() {
    if tmux has; then
        _popup_dotfilesdir
    else
        tmux new-session -A -s main -c "$(chezmoi source-path)"
    fi
}

alias ds='chezmoi status | grep -v "^ R"'

### }}}

## ===============================
##             :Alias
## ===============================

alias ls=ls\ --color=auto
alias vi=nvim
### nvim を less 代わりに使う
alias vl=nvim\ -R
## ## やりすぎ？
## export PAGER=nvim\ -R

## man で引数を撮って 'nvim -R' に渡す。さらに filetype=man を追加。
## function man() { man $1 | nvim -R ... } みたいな。

## compgen -c | fzf | xarges man

## export

export LESS='-R -X -i -P ?f%f:(stdin).  ?lb%lb?L/%L..  [?eEOF:?pb%pb\%..]'

## ===============================
##     :History_and_Completion
## ===============================
#
# ref: https://github.com/yammerjp/dotfiles/blob/main/.config/zsh/history.zsh

autoload -Uz history-search-end
zstyle ':completion:*' menu select

fzf-select-history() {
  BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
  CURSOR=$#BUFFER
  zle reset-prompt
}

zle -N fzf-select-history

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Bind arrow keys (adjust escape sequences for your terminal if needed)
bindkey '^k' up-line-or-beginning-search
bindkey '^n' down-line-or-beginning-search

bindkey '^r' fzf-select-history


HISTSIZE=50000 # メモリに保存するコマンド数
SAVEHIST=100000 # ヒストリファイルに保存するコマンド数
setopt extended_history # historyファイルに時刻情報を記録

# 複するコマンド行は古い方を削除
setopt hist_ignore_all_dups
# 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_dups
# コマンド履歴ファイルを共有する
setopt share_history
# 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt append_history
# 履歴をインクリメンタルに追加
setopt inc_append_history
# ヒストリを呼び出してから実行する間に一旦編集可能
setopt hist_verify
# 余分な空白は詰めて記録
setopt hist_reduce_blanks
# historyコマンドは履歴に登録しない
setopt hist_no_store
# 空白で始まるコマンドは履歴に登録しない
setopt hist_ignore_space


## [TODO]
## # shellのhistory一覧
## function select-history() {
##   BUFFER=$(history -n -r 1 | fzf --no-sort +m --height 50% --query "$LBUFFER" --prompt="History > ")
##   CURSOR=$#BUFFER
## }
## zle -N select-history
## bindkey '^t' select-history
## 
## # shellのhistory一覧
## function select-history-perfect-matching() {
##   BUFFER=$(history -n -r 1 | fzf -e --no-sort +m --height 50% --query "$LBUFFER" --prompt="History > ")
##   CURSOR=$#BUFFER
## }
## zle -N select-history-perfect-matching
## bindkey '^r' select-history-perfect-matching#


### -Completion-

compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# case prior
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'


## =========================
##            Git
## =========================


gitautocommit() {
    # Commit the most top change

    local fn
    git status --short | head -n 1 | sed 's/...//' | read fn
    [[ "$fn" == "" ]] && success "not modified" && return 0

    git add $fn
    git commit
}

## git_alias

alias gs=git\ status\ --short
alias ga=gitautocommit
alias gl="git log --name-status --date=format:'%Y-%m-%d %H:%M' --pretty=format:'%C(cyan)%cd %Cgreen[%cr]%n%s%n'"

## =========================
##          Util
## =========================

## python3 venv

function venv() {
    if [[ ! -d ".venv" ]]; then
        echo "venv new!"
        python3 -m venv .venv
    fi

    source .venv/bin/activate
}

## dive - trash
### dive で project を簡単作成
### trash でゴミ箱いき
### [TODO] メインのプロジェクトに移動させるコマンドを作る
# なのでワークフローとしては
# dive -> プロトタイプ:
# -   いらない -> trash-project
# -   いる     -> 管理下に移動 (その時リネームしたいかも)

function dive() {

    local DIVE_DIR="$HOME/workspace"
    local name="${1:-$(date +%Y%m%d)}"
    local dir="$DIVE_DIR/$name"
    local n=2

    while [[ -e "$dir" ]]; do
        dir="$DIVE_DIR/${name}-${n}"
        ((n++))
    done

    mkdir -p "$dir" || return
    cd "$dir" || return
    touch README.md
}

trash-project() {
    local DIVE_DIR="$HOME/workspace"
    local dir="$PWD"
    local trash="$DIVE_DIR/.trash"
    local name
    local dest
    local answer

    [[ "$dir" != "/" ]] || {
        echo "Cannot remove root directory."
        return 1
    }

    name=$(basename -- "$dir")
    mkdir -p -- "$trash" || return 1

    # tree っぽいものを表示
    find "../$name" -not -path '*/.*' | sed 's/[^/]*\//|-- /g'
    echo

    printf 'Move "%s" to trash? [y/N] ' "$dir"
    read -r answer
    [[ "$answer" == [yY] ]] || return 0

    dest="$trash/$name"
    # 重複なら timestamp を足す
    if [[ -e "$dest" ]]; then
        dest="$trash/${name}_$(date +%Y%m%d_%H%M%S)"
    fi

    mv -- "$dir" "$dest" || return 1

    echo "Moved to: $dest"
    cd "$DIVE_DIR" || return 1
}


## TODOSYSTEM: func t
export TODO_PROJECTS=~/.local/share/todo-system
t() {
    response="$($TODO_PROJECTS/func_t $1)"
    echo "r: $response"
    [ -d "$response" ] && cd "$response"
}

sora() { # Time and weather
    echo ''
    python3 ~/bin/sora.py
}

### }}}

## ===============================
##           :go_to
## ===============================

# export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
# export FZF_TMUX_OPTS=" -p90%,70% "

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude '.*' --exclude '_*'" 
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude '.*' --exclude '_*'" 
export FZF_DEFAULT_OPTS="--height 50% --layout=default --border --color=hl:#2dd4bf"
export FZF_TMUX_OPTS=" -p90%,70% "

# fzf-cd-widget == -ALT_C_COMMAND 適応
bindkey '^o' fzf-cd-widget

### fman: compgen search with fzf {{{

autoload -Uz bashcompinit
bashcompinit
alias fman="compgen -c | fzf | xargs man"

### }}}

# nvim で最近開いたファイル:
# -> :Telescope oldfiles
alias nof="vi -c ':Telescope oldfiles'"

## gg() {{{

gg() {

    case "$1" in

        "dot" )
            cd "$(chezmoi source-path)"
            ;;

        "zsh" )
            cd "$ZDOTDIR"
            ;;
        * )
            cd "$HOME/tes/"
            ;;
    esac

}

## }}}

## Tmux {{{

## dev: (/home/quiet/tes/TeckStack/zsh/src/open_session)

## open_session {{{
function _switch_client {
    # 外なら attach, 中なら switch

    if [[ ! -n "$2" ]]; then
        if [[ ! -n "$TMUX" ]]; then
            tmux attach-session -t "=$1"
        else
            tmux switch-client -t "=$1"
        fi
    else
        if [[ ! -n "$TMUX" ]]; then
            tmux attach-session -t "=$1" \; new-window -c "$2"
        else
            tmux switch-client -t "$1" \; new-window -c "$2"
        fi
    fi

}

# meke new session to switch
function _new_session {
    if [[ ! -n "$TMUX" ]]; then
        tmux new-session -s $1 -c $2
    else
        tmux new-session -d -s $1 -c $2
        tmux switch-client -t $1
    fi
}


function open_session {
    if [[ -z "$1" ]]; then
        echo " 指名の Session を開く"
        echo "Usage: open-sessoin <session_name> [--move]"
        return 1
    fi

    if tmux has -t "=$1" 2>/dev/null; then
        _switch_client $1 $2
    else
        _new_session $1 $2
    fi

}
### }}}

## attach selection with fzf
function :a {
    local result query selection

    result=$(tmux list-sessions -F '#{session_name}' |
           fzf --print-query --prompt="Session> ")

    exit_code=$?
    if [ $exit_code -eq 130 ]; then
        # fzf Cancel なら return
        echo Cancel
        return
    fi

    query=$(echo "$result" | sed -n '1p')
    selection=$(echo "$result" | sed -n '2p')

    # in lua session_name = selection || query || "New"
    session_name=${selection:-${query:-New}}

    tmux new-session -d -s $session_name
    _switch_client $session_name
}

function :t {
    open_session ToDo "$HOME/tes/"
}

## Detach Session

:d() {
if [[ -n "$TMUX" ]]; then
    tmux detach
fi
}

## Rename Session

:r() {
if [[ -n "$TMUX" ]]; then
   tmux rename-session $1
fi
}

# }}}

