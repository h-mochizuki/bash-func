#!/bin/bash
# =====================================
#  bash-func使用ライブラリを読み込みます
# =====================================
base="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"

[[ -d "$base/lib" ]] && for f in $(find "$base/lib" -type f); do
  source "$f"
done || echo "bash-func使用ライブラリの読み込みに失敗しました" >&2
