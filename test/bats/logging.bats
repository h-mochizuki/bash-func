#!/usr/bin/env bats
# =====================================
#           ログ出力関数テスト
# =====================================

setup() {
  # テスト対象モジュールの読込み
  load $BATS_TEST_DIRNAME/../../func/logging
  # テスト用にフォーマットを変更
  LOG_FORMAT='[%level]%msg'
}

@test "infoLog output : empty" {
  run infoLog
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[INFO ]' ]]
}

@test "infoLog output" {
  run infoLog 'This is {} TEST' 'infoLog'
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[INFO ]This is infoLog TEST' ]]
}

@test "warnLog output" {
  run warnLog 'This is {} TEST' 'warnLog'
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[WARN ]This is warnLog TEST' ]]
}

@test "errorLog output" {
  run errorLog 'This is {} TEST' 'errorLog'
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[ERROR]This is errorLog TEST' ]]
}

@test "infoLog output - multiline" {
  run infoLog 'This is {} TEST\nCan you hear me?' 'infoLog'
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[INFO ]This is infoLog TEST
Can you hear me?' ]]
}

@test "warnLog output - multiline" {
  run warnLog 'This is {} TEST\nCan you hear me?' 'warnLog'
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[WARN ]This is warnLog TEST
Can you hear me?' ]]
}

@test "errorLog output - multiline" {
  run errorLog 'This is {} TEST\nCan you hear me?' 'errorLog'
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[ERROR]This is errorLog TEST
Can you hear me?' ]]
}
