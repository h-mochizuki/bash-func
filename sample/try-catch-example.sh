#!/bin/bash

# try catchを試します
base="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"
source "${base}/../lib/try-catch"
source "${base}/../lib/log"

# ある例外
export AnException=100

# 条件がtrueのときはエラーにする
someErrorCondition=${1:-'1 -eq 1'}

try
(
  log.info "do something"
  [ $someErrorCondition ] && throw $AnException "This is Test"

  log.info "finished"
)
catch || {
  case $EXCEPTION_CD in
    $AnException)
      log.error "$EXCEPTION_CD : AnException was thrown"
    ;;
    *)
      log.error "$EXCEPTION_CD : An unexpected exception was thrown"
      throw $exitCd
    ;;
  esac
}
