#!/bin/bash

cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.1f", usage}')

# --- CPU（前回スナップショットとの差分）---
CACHE=~/.cache/_pc-info

## CUP 使用率 {{{
read_fields() {
    awk '/^cpu /{print $2,$3,$4,$5,$6,$7,$8; exit}' /proc/stat
}

calc_cpu() {
    read u n s id iw irq si <<< "$1"
    echo $(( u+n+s+id+iw+irq+si )) $(( u+n+s+irq+si ))
}

curr=$(read_fields)
read total_now busy_now <<< "$(calc_cpu "$curr")"

if [[ -f "$CACHE" ]]; then
    read total_prev busy_prev < "$CACHE"
    dt=$(( total_now - total_prev ))
    db=$(( busy_now  - busy_prev  ))
    if (( dt > 0 )); then
        cpu=$(awk "BEGIN{printf \"%.1f\", $db*100/$dt}")
    else
        cpu="0.0"
    fi
else
    cpu="0.0"   # 初回は値なし
fi

echo "$total_now $busy_now" > "$CACHE"
## }}}

# メモリ使用率
mem=$(free | awk '/Mem:/ {printf "%.1f", $3/$2 * 100.0}')

# GPU使用率 (NVIDIA用)
gpu=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null || echo "0")

# いい感じに整形して出力
# echo "💻 $cpu% | 🧠 $mem% | 🚀 $gpu%"
echo "🧠 $cpu% | 💭 $mem% | 🚀 $gpu%"

