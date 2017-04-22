#!/usr/bin/env bats
# =====================================
#           ログ出力関数テスト
# =====================================

setup() {
  # テスト対象モジュールの読込み
  load $BATS_TEST_DIRNAME/../lib/log
  # テスト用にフォーマットを変更
  LOG_FORMAT='[%level]%msg'
}

@test "log.info output : empty" {
  run log.info
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[INFO ]' ]
}

@test "log.info output" {
  run log.info 'This is {} TEST' 'log.info'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[INFO ]This is log.info TEST' ]
}

@test "log.warn output" {
  run log.warn 'This is {} TEST' 'log.warn'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[WARN ]This is log.warn TEST' ]
}

@test "log.error output" {
  run log.error 'This is {} TEST' 'log.error'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[ERROR]This is log.error TEST' ]
}

@test "log.info output - multiline" {
  run log.info 'This is {} TEST\nCan you hear me?' 'log.info'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[INFO ]This is log.info TEST
Can you hear me?' ]
}

@test "log.warn output - multiline" {
  run log.warn 'This is {} TEST\nCan you hear me?' 'log.warn'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[WARN ]This is log.warn TEST
Can you hear me?' ]
}

@test "log.error output - multiline" {
  run log.error 'This is {} TEST\nCan you hear me?' 'log.error'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[ERROR]This is log.error TEST
Can you hear me?' ]
}
