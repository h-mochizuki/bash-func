#!/bin/bash
# ----------------------------
#  スクリプト作成のテンプレート
# ----------------------------
base="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"
self="$(basename ${BASH_SOURCE:-$0})"

# -----------
#  Functions
# -----------
function _usage() {
  # usage
  cat <<USAGE >&2

usage)
  ./${self} [options] [parameters: p1, ...]
options)
  -h : Show this usage.
params)
  p1 : Please write description.
USAGE
}

function main() {
  # Main
  echo "$@"
}

# -----------
#  Processes
# -----------
# =Validate & Setting Options
while getopts h OPT
do
  case $OPT in
    h) _usage
       exit 0
    ;;
    \?) echo -en "\e[31m" # red color.
        _usage
        exit 1
  esac
done
shift $((OPTIND - 1))

# =Main Start
main "$@" &2>1
