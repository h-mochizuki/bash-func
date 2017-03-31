#!/usr/bin/env bats
# =====================================
#           文字列関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../../func/str
}

@test "str.match == false : empty" {
  run str.match
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" = '' ]]
}

@test "str.match == false : one param" {
  run str.match "regex"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" = '' ]]
}

@test "str.match == false : not equals" {
  run str.match 'abc' "def"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" = '' ]]
}

@test "str.match == true : equals" {
  run str.match 'abc' "abc"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" = 'abc' ]]
}

@test "str.match == true : groups" {
  run str.match '(.+)-(.+)' "1234-5678"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" = '1234-5678 1234 5678' ]]
}

@test "str.indexOf == -1 : not exists" {
  run str.indexOf "hoge" "piyo"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" -eq -1 ]]
}

@test "str.indexOf == 0 : empty" {
  run str.indexOf
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" -eq 0 ]]
}

@test "str.indexOf == 1 : exists" {
  run str.indexOf "hoge" "1hoge"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" -eq 1 ]]
}

@test "str.indexOf == 3 : stream" {
  run str.indexOf "hoge" <<< "123hoge"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" -eq 3 ]]
}

@test "str.contains == false : empty" {
  run str.contains "hoge"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.contains == false : not contains" {
  run str.contains "hoge" "abc"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.contains == true : contains" {
  run str.contains "hoge" <<< "123hoge"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "str.toLower : HOGEhoge => hogehoge" {
  run str.toLower "HOGEhoge"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "hogehoge" ]]
}

@test "str.toUpper : HOGEhoge => HOGEHOGE" {
  run str.toUpper "HOGEhoge"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "HOGEHOGE" ]]
}

@test "str.isInteger - false : empty" {
  run str.isInteger
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.isInteger - false : string" {
  run str.isInteger "abcdefg"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.isInteger - false : decimal" {
  run str.isInteger "1.2"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.isInteger - false : plus" {
  run str.isInteger "+123456"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.isInteger - true : integer" {
  run str.isInteger "123456"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "str.isInteger - true : minus" {
  run str.isInteger "-123456"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "str.isNumber - false : empty" {
  run str.isNumber
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.isNumber - false : string" {
  run str.isNumber "abcdefg"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.isNumber - true : decimal" {
  run str.isNumber "1.2"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "str.isNumber - false : dot" {
  run str.isNumber "1.2.3"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.isNumber - false : plus" {
  run str.isNumber "+1.2"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "str.isNumber - true : minus" {
  run str.isNumber "-1.2"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "str.isNumber - true : integer" {
  run str.isNumber "123456"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "str.times : empty" {
  run str.times
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '' ]]
}

@test "str.times : 1 char 5 times" {
  run str.times '1' 5
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '11111' ]]
}

@test "str.times : 5 char 5 times" {
  run str.times '12345' 5
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == '1234512345123451234512345' ]]
}
