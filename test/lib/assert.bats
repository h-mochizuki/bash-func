#!/usr/bin/env bats
# =====================================
#             評価関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../../scripts/lib/assert
  EXEC_FILE="${BATS_TMPDIR}/execfile"
  touch "${EXEC_FILE}"
  chmod +x "${EXEC_FILE}"
  NOTEXEC_FILE="${BATS_TMPDIR}/notexecfile"
  touch "${NOTEXEC_FILE}"

  # テスト用にフォーマットを変更
  LOG_FORMAT='[%level]%msg'
}

teardown() {
  if [ ! -z "${EXEC_FILE+x}" ];then
    rm -f "${EXEC_FILE}"
  fi
  if [ ! -z "${NOTEXEC_FILE+x}" ];then
    rm -f touch "${NOTEXEC_FILE}"
  fi
}

@test "assert.installed : function" {
  run assert.installed assert.installed
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.installed : builtin" {
  run assert.installed type
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.installed : file" {
  run assert.installed wget
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.installed : alias" {
  run assert.installed ls
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.installed : not defined" {
  run assert.installed notdefinedcommand
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "assert.executable : empty" {
  run assert.executable
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "assert.executable : executable" {
  run assert.executable "${EXEC_FILE}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.executable : not executable" {
  run assert.executable "${NOTEXEC_FILE}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "assert.exec : success" {
  run assert.exec true
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${#output}" == 0 ]
}

@test "assert.exec : failure" {
  run assert.exec false
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '[ERROR]!!FAILED!! -exec-> false ' ]
}
