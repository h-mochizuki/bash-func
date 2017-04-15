#!/bin/bash
# =====================================
#      shunit2インストールチェック
# =====================================
BASE="$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)"
DOWNLOAD_DIR_NAME="shunit2-module"
ARCHIVE_FILE='shunit2-2.1.6.tgz'
DOWNLOAD_URL="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/shunit2/${ARCHIVE_FILE}"

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
  if [[ ! $(type -t shunit2) == '' ]];then
    echo;
    infoLog "既にshunit2がインストールされています"
    infoLog " -> which shunit2 : $(type -p shunit2)"
    exit 0
  fi

  echo "[$(date +'%Y-%m-%d %H:%M:%s')]shunit2のインストールを実施します"
  if [[ $(type -t wget) == '' ]];then
    echo;
    errorLog "wget コマンドが実行できません"
    errorLog "エラーにより処理を終了します"
    exit 9
  fi

  if [[ -d "${DOWNLOAD_DIR}" ]];then
    rm -rf "${DOWNLOAD_DIR}"
    echo;
    infoLog "既存のshunit2モジュールディレクトリを削除しました"
    infoLog " -> rm -r ${DOWNLOAD_DIR}"
  fi

  echo;
  infoLog "shunit2モジュールを取得します"
  cd "${BASE}"
  wget "${DOWNLOAD_URL}"
  tar zxvf "${ARCHIVE_FILE}"
  mv "${ARCHIVE_FILE%.*}" "${DOWNLOAD_DIR}"
  infoLog "最新のshunit2モジュールを取得しました"
  cd "${DOWNLOAD_DIR}"
}

install 2>&1 | tee -a "shunit2-install-$(date +'%Y%m%d').log"
