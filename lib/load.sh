#!/bin/bash
# =====================================
#            一括読み込み関数定義
# -------------------------------------
#  指定ディレクトリ内のファイルを source します
# =====================================
base="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"

__usage() {
  echo "usage : source $(basename ${0}) <directries>"
  echo;
  echo "----"
  echo "directries:"
  echo "  The file immediately under the specified directory is loaded."
  echo "----"
  echo "Setting exclude parameters:"
  echo "  EXCLUDE_LIBRARY_PATTERNS) Exclude library patterns."
  echo "     Set regex expression pattern like '*.sh|*.conf'"
  echo;
}

__loadable() {
  local s
  # 一度読んだら読み込みたくない
  for s in "${__STACK_LIBRARIES[@]}";do
    if [[ "__${s}__" == "__${1:-$s}__" ]];then
      return 1
    fi
  done
  # 除外パターン
  for s in "${__EXCLUDE_LIBRARY_PATTERNS[@]}";do
    if [[ "$1" =~ $s ]];then
      return 1
    fi
  done
  # 循環参照
  for s in "${BASH_SOURCE[@]}";do
    s="$(cd $(dirname $s);pwd)/$(basename $s)"
    if [[ "__${s}__" == "__${1:-$s}__" ]];then
      return 1
    fi
  done
  return 0
}

# ----------------
#     メイン処理
# ----------------
# 読み込み除外パターン
declare -a __EXCLUDE_LIBRARY_PATTERNS=( "${EXCLUDE_LIBRARY_PATTERNS[@]}" )
# 既に読み込んだライブラリ
declare -a __STACK_LIBRARIES=( "${base}/$(basename ${BASH_SOURCE:-$0})" )

# ディレクトリ存在チェック
for d in "$@";do
  if [[ ! -d "$d" ]];then
    echo "Directory not found Exception : $d" 1>&2
    __usage
    return 1
  fi
done

# ディレクトリごとに読み込み
for d in "$@";do
  for f in $(find "$d" -maxdepth 1 -type f);do
    f="$(cd $(dirname $f);pwd)/$(basename $f)"
    if __loadable "$f";then
      __STACK_LIBRARIES+=( "$f" )
      source "$f"
    fi
  done
done
