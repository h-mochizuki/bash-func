#!/usr/bin/env bats
# =====================================
#           計測関係関数テスト
# =====================================

setup() {
  # テスト対象モジュールの読込み
  load $BATS_TEST_DIRNAME/../../func/watch
  ELAPSED_FORMAT='[elapsed %-S sec]'
}

@test "watch.elapsed : empty -> [elapsed 0 sec]" {
  run watch.elapsed
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[elapsed 0 sec]' ]]
}

@test "watch.elapsed : true -> [elapsed 0 sec]" {
  run watch.elapsed true
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[elapsed 0 sec]' ]]
}

@test "watch.elapsed : false -> [elapsed 0 sec]" {
  run watch.elapsed false
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" == '[elapsed 0 sec]' ]]
}

@test "watch.elapsed : sleep 5s -> [elapsed 5 sec]" {
  run watch.elapsed sleep 5s
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '[elapsed 5 sec]' ]]
}

@test "watch.diffTimestamp : 0 ~ 0 -> 0s" {
  run watch.diffTimestamp 0 0
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '0s' ]]
}

@test "watch.diffTimestamp : 0 ~ 10 -> 10s" {
  run watch.diffTimestamp 0 10
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '10s' ]]
}

@test "watch.diffTimestamp : 10 ~ 0 -> 10s" {
  run watch.diffTimestamp 10 0
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '10s' ]]
}

@test "watch.sec2Date" {
  TEST_TIMESTAMP=$(date +%s)
  TEST_DATE_FORMAT='%Y-%m-%d %H:%M:%S'
  TEST_DATE=$(date -d @${TEST_TIMESTAMP} +"${TEST_DATE_FORMAT}")

  run watch.sec2Date "${TEST_TIMESTAMP}" "${TEST_DATE_FORMAT}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "$TEST_DATE" ]]
}

@test "watch.millis2Date" {
  TEST_TIMESTAMP=$(date +%s.%3N)
  TEST_DATE_FORMAT='%Y-%m-%d %H:%M:%S'
  TEST_DATE=$(date -d @${TEST_TIMESTAMP} +"${TEST_DATE_FORMAT}")

  run watch.millis2Date "${TEST_TIMESTAMP/./}" "${TEST_DATE_FORMAT}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "$TEST_DATE" ]]
}

@test "watch.nanos2Date" {
  TEST_TIMESTAMP=$(date +%s.%N)
  TEST_DATE_FORMAT='%Y-%m-%d %H:%M:%S'
  TEST_DATE=$(date -d @${TEST_TIMESTAMP} +"${TEST_DATE_FORMAT}")

  run watch.nanos2Date "${TEST_TIMESTAMP/./}" "${TEST_DATE_FORMAT}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "$TEST_DATE" ]]
}
