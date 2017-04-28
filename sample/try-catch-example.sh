#!/bin/sh

# try catchを試します
base="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"
source ${base}/../lib/try-catch

# ある例外
export AnException=100

# 条件がtrueのときはエラーにする
someErrorCondition=${1:-'1 -eq 1'}

try
(
  echo "do something"
  [ $someErrorCondition ] && throw $AnException "This is Test"

  echo "finished"
)
catch || {
  case $EXCEPTION_CD in
    $AnException)
      echo "$EXCEPTION_CD : AnException was thrown"
    ;;
    *)
      echo "$EXCEPTION_CD : An unexpected exception was thrown"
      throw $exitCd
    ;;
  esac
}
