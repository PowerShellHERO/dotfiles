#!/bin/bash
# CPU使用率 (前回との差分を取るのが正確ですが、簡易的に1秒の平均を取得)
cpu=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {printf "%.1f", usage}')

# メモリ使用率
mem=$(free | awk '/Mem:/ {printf "%.1f", $3/$2 * 100.0}')

# GPU使用率 (NVIDIA用)
gpu=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null || echo "0")

# いい感じに整形して出力
# echo "💻 $cpu% | 🧠 $mem% | 🚀 $gpu%"
echo "🧠 $cpu% | 💭 $mem% | 🚀 $gpu%"

