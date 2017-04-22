#!/usr/bin/env bats
# =====================================
#           時間関係関数テスト
# =====================================

setup() {
  # テスト対象モジュールの読込み
  load $BATS_TEST_DIRNAME/../../scripts/lib/time
  ELAPSED_FORMAT='[elapsed %-S sec]'
}

@test "time.elapsed : empty -> [elapsed 0 sec]" {
  run time.elapsed
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[elapsed 0 sec]' ]
}

@test "time.elapsed : true -> [elapsed 0 sec]" {
  run time.elapsed true
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[elapsed 0 sec]' ]
}

@test "time.elapsed : false -> [elapsed 0 sec]" {
  run time.elapsed false
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '[elapsed 0 sec]' ]
}

@test "time.elapsed : sleep 5s -> [elapsed 5 sec]" {
  run time.elapsed sleep 5s
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '[elapsed 5 sec]' ]
}

@test "time.diffTimestamp : 0 ~ 0 -> 0s" {
  run time.diffTimestamp 0 0
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '0s' ]
}

@test "time.diffTimestamp : 0 ~ 10 -> 10s" {
  run time.diffTimestamp 0 10
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '10s' ]
}

@test "time.diffTimestamp : 10 ~ 0 -> 10s" {
  run time.diffTimestamp 10 0
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '10s' ]
}

@test "time.sec2Date" {
  TEST_TIMESTAMP=$(date +%s)
  TEST_DATE_FORMAT='%Y-%m-%d %H:%M:%S'
  TEST_DATE=$(date -d @${TEST_TIMESTAMP} +"${TEST_DATE_FORMAT}")

  run time.sec2Date "${TEST_TIMESTAMP}" "${TEST_DATE_FORMAT}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "$TEST_DATE" ]
}

@test "time.millis2Date" {
  TEST_TIMESTAMP=$(date +%s.%3N)
  TEST_DATE_FORMAT='%Y-%m-%d %H:%M:%S'
  TEST_DATE=$(date -d @${TEST_TIMESTAMP} +"${TEST_DATE_FORMAT}")

  run time.millis2Date "${TEST_TIMESTAMP/./}" "${TEST_DATE_FORMAT}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "$TEST_DATE" ]
}

@test "time.nanos2Date" {
  TEST_TIMESTAMP=$(date +%s.%N)
  TEST_DATE_FORMAT='%Y-%m-%d %H:%M:%S'
  TEST_DATE=$(date -d @${TEST_TIMESTAMP} +"${TEST_DATE_FORMAT}")

  run time.nanos2Date "${TEST_TIMESTAMP/./}" "${TEST_DATE_FORMAT}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "$TEST_DATE" ]
}

@test "time.timeout : in time " {
  run time.timeout 3s bash -c 'sleep 1s; echo "hoge"'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'hoge' ]
}

@test "time.timeout : over time " {
  run time.timeout 3s bash -c 'sleep 5s; echo "hoge"'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 124 ]
  [ "${output}" == '' ]
}
