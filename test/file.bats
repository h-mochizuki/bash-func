#!/usr/bin/env bats
# =====================================
#             評価関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../lib/file
  EXECUTABLE_FILE="${BATS_TMPDIR}/execfile"
  touch "${EXECUTABLE_FILE}"
  chmod +x "${EXECUTABLE_FILE}"
  NOTEXECUTABLE_FILE="${BATS_TMPDIR}/notexecfile"
  touch "${NOTEXECUTABLE_FILE}"

  # テスト用にフォーマットを変更
  LOG_FORMAT='[%level]%msg'
}

teardown() {
  if [ ! -z "${EXECUTABLE_FILE+x}" ];then
    rm -f "${EXECUTABLE_FILE}"
  fi
  if [ ! -z "${NOTEXECUTABLE_FILE+x}" ];then
    rm -f touch "${NOTEXECUTABLE_FILE}"
  fi
}

@test "file.executable : empty" {
  run file.executable
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "file.executable : executable" {
  run file.executable "${EXECUTABLE_FILE}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "file.executable : not executable" {
  run file.executable "${NOTEXECUTABLE_FILE}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}
