#!/bin/bash
# =====================================
#        Batsインストールチェック
# =====================================
BASE="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"
DOWNLOAD_DIR_NAME="bats-module"
INSTALL_DIR="/usr/local"
DOWNLOAD_URL='https://github.com/sstephenson/bats.git'

function __log() {
  echo "[$(date +'%Y-%m-%d %H:%M:%s')]$*"
}

function infoLog(){
  __log "$@"
}

function errorLog(){
  __log "$@" 1>&2
}

function install() {
  set -e
  DOWNLOAD_DIR="${BASE}/${DOWNLOAD_DIR_NAME}"
  if [[ ! $(type -t bats) == '' ]];then
    echo;
    infoLog "既にBatsがインストールされています"
    infoLog " -> which bats : $(type -p bats)"
    exit 0
  fi

  echo "[$(date +'%Y-%m-%d %H:%M:%s')]Batsのインストールを実施します"
  if [[ $(type -t git) == '' ]];then
    echo;
    errorLog "git コマンドが実行できません"
    errorLog "エラーにより処理を終了します"
    exit 9
  fi

  if [[ -d "${DOWNLOAD_DIR}" ]];then
    rm -rf "${DOWNLOAD_DIR}"
    echo;
    infoLog "既存のBatsモジュールディレクトリを削除しました"
    infoLog " -> rm -r ${DOWNLOAD_DIR}"
  fi

  echo;
  infoLog "Batsモジュールを取得します"
  cd "${BASE}"
  git clone "${DOWNLOAD_URL}" ${DOWNLOAD_DIR_NAME}
  infoLog "最新のBatsモジュールを取得しました"
  cd "${DOWNLOAD_DIR}"
  ${DOWNLOAD_DIR}/install.sh "${INSTALL_DIR}"
  infoLog "Batsモジュールのインストールが完了しました"

  if [[ -d "${DOWNLOAD_DIR}" ]];then
    rm -rf "${DOWNLOAD_DIR}"
    echo;
    infoLog "不要となったBatsモジュールディレクトリを削除しました"
    infoLog " -> rm -r ${DOWNLOAD_DIR}"
  fi

  echo;
  infoLog "Batsのインストールが完了しました"
  echo;
}

install 2>&1 | tee -a "bats-install-$(date +'%Y%m%d').log"
