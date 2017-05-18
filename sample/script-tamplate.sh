#!/bin/bash
# ----------------------------
#  スクリプト作成のテンプレート
# ----------------------------
base="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"
self="$(basename ${BASH_SOURCE:-$0})"

# -----------
#   変数定義
# -----------
# 入力引数
args=()

# -----------
#   関数定義
# -----------
function _usage() {
  # 使用方法
  cat <<USAGE >&2

usage)
  ./${self} [options: -h] [parameters: text, ...]
options)
  -h : Show this usage.
params)
  text : Please input text.
         (Default: Current-date)
USAGE
}

function main() {
  # メイン処理
  echo "$@"
}

# --------------
#  入力チェック
# --------------
# オプションを設定します
while getopts h OPT
do
  case $OPT in
    h) # ヘルプ
      _usage
      exit 0
    ;;
    \?) # 想定外のオプション
      echo -en "\e[31m" # 赤くする
      _usage
      exit 1
  esac
done
shift $((OPTIND - 1))

# 引数チェック
if [[ "$#" -eq 0 ]];then
  echo -e "\e[31m引数がありません。現在日付を代入します\e[m"
  args=( "$(date +'%Y-%m-%d')" "$(date +'%H:%M:%S')" )
else
  args=( "$@" )
fi

# --------------
#  メイン処理実行
# --------------
main "${args[@]}" &2>1
