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
}

teardown() {
  if [ ! -z "${EXECUTABLE_FILE+x}" ];then
    rm -f "${EXECUTABLE_FILE}"
  fi
  if [ ! -z "${NOTEXECUTABLE_FILE+x}" ];then
    rm -f "${NOTEXECUTABLE_FILE}"
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

@test "file.isBelongedTo : empty" {
  run file.isBelongedTo
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "file.isBelongedTo : not found" {
  run file.isBelongedTo "hogehogepiyopiyo"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "file.isBelongedTo file.bats" {
  pushd "${BATS_TEST_DIRNAME}"
  run file.isBelongedTo "file.bats"
  popd
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "${BATS_TEST_DIRNAME}/file.bats" ]
}

@test "file.isBelongedTo $(basename ${BATS_TEST_DIRNAME})" {
  parent="$(basename ${BATS_TEST_DIRNAME})"
  run file.isBelongedTo "${parent}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "${BATS_TEST_DIRNAME}" ]
}
