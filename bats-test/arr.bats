#!/usr/bin/env bats
# =====================================
#           配列操作関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../func/arr
  TEST_ARRAY=( "ONE" "TWO" "THREE" )
}

@test "arr.indexOf <= 0 : not exists" {
  run arr.indexOf "ZERO" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" -eq -1 ]]
}

@test "arr.indexOf <= ONE : [0]" {
  run arr.indexOf "ONE" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" -eq 0 ]]
}

@test "arr.indexOf <= TWO : [1]" {
  run arr.indexOf "TWO" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" -eq 1 ]]
}

@test "arr.indexOf <= THREE : [2]" {
  run arr.indexOf "THREE" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" -eq 2 ]]
}

@test "arr.hasElement : not exists" {
  run arr.hasElement "ZERO" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
}

@test "arr.hasElement : exists" {
  run arr.hasElement "ONE" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
}

@test "arr.car : empy" {
  run arr.car
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" = "" ]]
}

@test "arr.car : has 1 element" {
  run arr.car "ONE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "ONE" ]]
}

@test "arr.car : has more element" {
  run arr.car "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "ONE" ]]
}

@test "arr.cdr : empy" {
  run arr.cdr
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" = "" ]]
}

@test "arr.cdr : has 1 element" {
  run arr.cdr "ONE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "" ]]
}

@test "arr.cdr : has more element" {
  run arr.cdr "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "TWO THREE" ]]
}

@test "arr.last : empy" {
  run arr.last
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" = "" ]]
}

@test "arr.last : has 1 element" {
  run arr.last "ONE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "ONE" ]]
}

@test "arr.last : has more element" {
  run arr.last "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "THREE" ]]
}
