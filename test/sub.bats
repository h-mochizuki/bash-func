#!/usr/bin/env bats

setup() {
  load "$BATS_TEST_DIRNAME/../lib/file"
  load "$BATS_TEST_DIRNAME/../lib/sub"
  export TEST_DIR=$(mktemp -d)
  cd "$TEST_DIR"
}

teardown() {
  cd - > /dev/null
  rm -rf "$TEST_DIR"
}

@test "sub.new creates .subrc if it does not exist" {
  run sub.new
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [[ "${output}" =~ ".subrc is not found." ]]
  [[ "${output}" =~ "created init-file: ${TEST_DIR}/.subrc" ]]
  [ -f "${TEST_DIR}/.subrc" ]
}



@test "sub.new uses existing .subrc if it exists" {
  echo "echo 'Existing .subrc content'" > "${TEST_DIR}/.subrc"
  run sub.new
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [[ ! "${output}" =~ ".subrc is not found." ]]
  [[ ! "${output}" =~ "created init-file:" ]]
}

@test "sub.temp attempts to create a temporary init file" {
  run sub.temp
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}