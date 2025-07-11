#!/usr/bin/env bats
# =====================================
#             数値関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../lib/num
}

@test "num.isInteger - false : empty" {
  run num.isInteger
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "num.isInteger - false : numing" {
  run num.isInteger "abcdefg"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "num.isInteger - false : decimal" {
  run num.isInteger "1.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "num.isInteger - false : plus" {
  run num.isInteger "+123456"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "num.isInteger - true : integer" {
  run num.isInteger "123456"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "num.isInteger - true : minus" {
  run num.isInteger "-123456"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "num.isInteger - true : zero" {
  run num.isInteger "0"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "num.isInteger - false : negative decimal" {
  run num.isInteger "-1.0"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "num.isNumber - false : empty" {
  run num.isNumber
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "num.isNumber - false : numing" {
  run num.isNumber "abcdefg"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "num.isNumber - true : decimal" {
  run num.isNumber "1.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "num.isNumber - false : dot" {
  run num.isNumber "1.2.3"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "num.isNumber - false : plus" {
  run num.isNumber "+1.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "num.isNumber - true : minus" {
  run num.isNumber "-1.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "num.isNumber - true : integer" {
  run num.isNumber "123456"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "num.isNumber - true : zero" {
  run num.isNumber "0"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "num.isNumber - true : negative zero" {
  run num.isNumber "-0"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "num.greaterThan : empty" {
  run num.greaterThan 
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : illegal param1 only" {
  run num.greaterThan "illegal"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1 only" {
  run num.greaterThan "1"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : illegal param2" {
  run num.greaterThan "1" "illegal"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : illegal params" {
  run num.greaterThan "illegal1" "illegal2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : illegal param1" {
  run num.greaterThan "illegal1" "1"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1==param2" {
  run num.greaterThan "123" "123"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1<param2" {
  run num.greaterThan "1" "2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1>param2" {
  run num.greaterThan "3" "2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1==param2 (decimal)" {
  run num.greaterThan "1.23" "1.23"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1<param2 (decimal)" {
  run num.greaterThan "0.1" "0.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1>param2 (decimal)" {
  run num.greaterThan "0.3" "0.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1==param2 (negative)" {
  run num.greaterThan -1 -1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1<param2 (negative)" {
  run num.greaterThan -3 -1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.greaterThan : param1>param2 (negative)" {
  run num.greaterThan -1 -3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : empty" {
  run num.lesserThan 
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : illegal param1 only" {
  run num.lesserThan "illegal"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1 only" {
  run num.lesserThan "1"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : illegal param2" {
  run num.lesserThan "1" "illegal"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : illegal params" {
  run num.lesserThan "illegal1" "illegal2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : illegal param1" {
  run num.lesserThan "illegal1" "1"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1==param2" {
  run num.lesserThan "123" "123"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1<param2" {
  run num.lesserThan "1" "2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1>param2" {
  run num.lesserThan "3" "2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1==param2 (decimal)" {
  run num.lesserThan "1.23" "1.23"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1<param2 (decimal)" {
  run num.lesserThan "0.1" "0.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1>param2 (decimal)" {
  run num.lesserThan "0.3" "0.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1==param2 (negative)" {
  run num.lesserThan -1 -1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1<param2 (negative)" {
  run num.lesserThan -3 -1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "num.lesserThan : param1>param2 (negative)" {
  run num.lesserThan -1 -3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.max : empty" {
  run num.max
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.max : illegal" {
  run num.max illegal
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.max : 1 => 1" {
  run num.max 1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '1' ]
}

@test "num.max : 1 2 => 2" {
  run num.max 1 2
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '2' ]
}

@test "num.max : 1 2 3 => 3" {
  run num.max 1 2 3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '3' ]
}

@test "num.max : 1 10 3 => 10" {
  run num.max 1 10 3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '10' ]
}

@test "num.max : 1 0 -1 => 1" {
  run num.max 1 0 -1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '1' ]
}

@test "num.max : decimal values" {
  run num.max 1.1 2.2 3.3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '3.3' ]
}

@test "num.max : negative values" {
  run num.max -1 -2 -3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '-1' ]
}

@test "num.max : mix negative and decimal" {
  run num.max -1.5 0 2.5
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '2.5' ]
}

@test "num.max : all illegal" {
  run num.max a b c
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.max : mix illegal and valid" {
  run num.max 1 a 2 b 3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '3' ]
}

@test "num.min : empty" {
  run num.min
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.min : illegal" {
  run num.min illegal
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.min : 1 => 1" {
  run num.min 1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '1' ]
}

@test "num.min : 1 2 => 1" {
  run num.min 1 2
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '1' ]
}

@test "num.min : 1 2 3 => 1" {
  run num.min 1 2 3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '1' ]
}

@test "num.min : 5 10 3 => 3" {
  run num.min 5 10 3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '3' ]
}

@test "num.min : 1 0 -1 => -1" {
  run num.min 1 0 -1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '-1' ]
}

@test "num.min : decimal values" {
  run num.min 1.1 2.2 3.3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '1.1' ]
}

@test "num.min : negative values" {
  run num.min -1 -2 -3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '-3' ]
}

@test "num.min : mix negative and decimal" {
  run num.min -1.5 0 2.5
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '-1.5' ]
}

@test "num.min : all illegal" {
  run num.min a b c
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "num.min : mix illegal and valid" {
  run num.min 1 a 2 b 3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '1' ]
}

@test "num.average : 1 0 -1 => 0" {
  run num.average 1 0 -1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '0' ]
}

@test "num.average : 1 2 3 => 2" {
  run num.average 1 2 3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '2' ]
}

@test "num.average : 1 2 3 4 5 6 7 8 9 10 => 5.5" {
  run num.average 1 2 3 4 5 6 7 8 9 10
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '5.5' ]
}

@test "num.average : empty" {
  run num.average
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '0' ]
}

@test "num.average : all illegal" {
  run num.average a b c
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '0' ]
}

@test "num.average : single value" {
  run num.average 42
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '42' ]
}

@test "num.average : negative and decimal" {
  run num.average -1.5 2.5
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '0.5' ]
}

@test "num.average : mix illegal and valid" {
  run num.average 1 a 2 b 3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '2' ]
}

@test "num.average : zeroes" {
  run num.average 0 0 0
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '0' ]
}

@test "num.average : negative zeroes" {
  run num.average -0 -0 -0
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '0' ]
}
