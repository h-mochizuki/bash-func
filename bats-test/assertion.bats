#!/usr/bin/env bats
# =====================================
#             評価関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../func/assertion
  EXEC_FILE="${BATS_TMPDIR}/execfile"
  touch "${EXEC_FILE}"
  chmod +x "${EXEC_FILE}"
  NOTEXEC_FILE="${BATS_TMPDIR}/notexecfile"
  touch "${NOTEXEC_FILE}"

  # テスト用にフォーマットを変更
  LOG_FORMAT='[%level]%msg'
}

teardown() {
  if [[ ! -z "${EXEC_FILE+x}" ]];then
    rm -f "${EXEC_FILE}"
  fi
  if [[ ! -z "${NOTEXEC_FILE+x}" ]];then
    rm -f touch "${NOTEXEC_FILE}"
  fi
}

@test "isExecutable : empty" {
  run isExecutable
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "isExecutable : executable" {
  run isExecutable "${EXEC_FILE}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "isExecutable : not executable" {
  run isExecutable "${NOTEXEC_FILE}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "isInstalled : function" {
  run isInstalled isInstalled
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "isInstalled : builtin" {
  run isInstalled type
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "isInstalled : file" {
  run isInstalled wget
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "isInstalled : alias" {
  run isInstalled ls
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "isInstalled : not defined" {
  run isInstalled notdefinedcommand
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "assert : success" {
  run assert true
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${#output[0]}" == 0 ]]
}

@test "assert : failure" {
  run assert false
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" == '[ERROR]!!FAILED!! -exec-> false ' ]]
}
