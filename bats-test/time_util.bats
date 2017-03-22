#!/usr/bin/env bats
# =====================================
#           時間計測関数テスト
# =====================================

setup() {
  # テスト対象モジュールの読込み
  load $BATS_TEST_DIRNAME/../func/time_util
}

@test "__scaleTimeUnitDiff HOGE : error" {
  run __scaleTimeUnitDiff HOGE
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" == "IllegalTimeUnitError : 'HOGE' 'NANOSECONDS'" ]]
}

@test "__scaleTimeUnitDiff NANOSECONDS - NANOSECONDS : 1" {
  run __scaleTimeUnitDiff NANOSECONDS NANOSECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1 ]]
}

@test "__scaleTimeUnitDiff MICROSECONDS - MICROSECONDS : 1" {
  run __scaleTimeUnitDiff MICROSECONDS MICROSECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1 ]]
}

@test "__scaleTimeUnitDiff MILLISECONDS - MILLISECONDS : 1" {
  run __scaleTimeUnitDiff MILLISECONDS MILLISECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1 ]]
}

@test "__scaleTimeUnitDiff SECONDS - SECONDS : 1" {
  run __scaleTimeUnitDiff SECONDS SECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1 ]]
}

@test "__scaleTimeUnitDiff MINUTES - MINUTES : 1" {
  run __scaleTimeUnitDiff MINUTES MINUTES
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1 ]]
}

@test "__scaleTimeUnitDiff HOURS - HOURS : 1" {
  run __scaleTimeUnitDiff HOURS HOURS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1 ]]
}

@test "__scaleTimeUnitDiff NANOSECONDS - MICROSECONDS : 1000" {
  run __scaleTimeUnitDiff NANOSECONDS MICROSECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1000 ]]
}

@test "__scaleTimeUnitDiff NANOSECONDS - MILLISECONDS : 1000000" {
  run __scaleTimeUnitDiff NANOSECONDS MILLISECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1000000 ]]
}

@test "__scaleTimeUnitDiff NANOSECONDS - SECONDS : 1000000000" {
  run __scaleTimeUnitDiff NANOSECONDS SECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1000000000 ]]
}

@test "__scaleTimeUnitDiff NANOSECONDS - MINUTES : 60000000000" {
  run __scaleTimeUnitDiff NANOSECONDS MINUTES
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 60000000000 ]]
}

@test "__scaleTimeUnitDiff NANOSECONDS - HOURS : 3600000000000" {
  run __scaleTimeUnitDiff NANOSECONDS HOURS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 3600000000000 ]]
}

@test "__scaleTimeUnitDiff MICROSECONDS - MILLISECONDS : 1000" {
  run __scaleTimeUnitDiff MICROSECONDS MILLISECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1000 ]]
}

@test "__scaleTimeUnitDiff MICROSECONDS - SECONDS : 1000000" {
  run __scaleTimeUnitDiff MICROSECONDS SECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1000000 ]]
}

@test "__scaleTimeUnitDiff MICROSECONDS - MINUTES : 60000000" {
  run __scaleTimeUnitDiff MICROSECONDS MINUTES
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 60000000 ]]
}

@test "__scaleTimeUnitDiff MICROSECONDS - MICROSECONDS : 3600000000" {
  run __scaleTimeUnitDiff MICROSECONDS HOURS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 3600000000 ]]
}

@test "__scaleTimeUnitDiff MILLISECONDS - SECONDS : 1000" {
  run __scaleTimeUnitDiff MILLISECONDS SECONDS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 1000 ]]
}

@test "__scaleTimeUnitDiff MILLISECONDS - MINUTES : 60000" {
  run __scaleTimeUnitDiff MILLISECONDS MINUTES
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 60000 ]]
}

@test "__scaleTimeUnitDiff MILLISECONDS - HOURS : 3600000" {
  run __scaleTimeUnitDiff MILLISECONDS HOURS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 3600000 ]]
}

@test "__scaleTimeUnitDiff SECONDS - MINUTES : 60" {
  run __scaleTimeUnitDiff SECONDS MINUTES
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 60 ]]
}

@test "__scaleTimeUnitDiff SECONDS - HOURS : 3600" {
  run __scaleTimeUnitDiff SECONDS HOURS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 3600 ]]
}

@test "__scaleTimeUnitDiff MINUTES - HOURS : 60" {
  run __scaleTimeUnitDiff MINUTES HOURS
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 60 ]]
}

@test "__scaleTimeUnitDiff HOURS - MINUTES : 60" {
  run __scaleTimeUnitDiff HOURS MINUTES
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == 60 ]]
}
