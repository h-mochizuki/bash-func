#!/usr/bin/env bats
# =====================================
#           配列操作関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../../scripts/lib/arr
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

@test "arr.take : empy" {
  run arr.take
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" = "" ]]
}

@test "arr.take : not number" {
  run arr.take "ONE" "ONE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" == "" ]]
}

@test "arr.take : negative number" {
  run arr.take "ONE" "ONE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" == "" ]]
}

@test "arr.take : take 1 element" {
  run arr.take 1 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "ONE" ]]
}

@test "arr.take : take match-size elements" {
  run arr.take 3 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "ONE TWO THREE" ]]
}

@test "arr.take : take over-size elements" {
  run arr.take 10 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "ONE TWO THREE" ]]
}

@test "arr.drop : empy" {
  run arr.drop
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" = "" ]]
}

@test "arr.drop : not number" {
  run arr.drop "ONE" "ONE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" == "" ]]
}

@test "arr.drop : negative number" {
  run arr.drop "ONE" "ONE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 1 ]]
  [[ "${output[0]}" == "" ]]
}

@test "arr.drop : drop 1 element" {
  run arr.drop 1 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "TWO THREE" ]]
}

@test "arr.drop : drop 2 element" {
  run arr.drop 2 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "THREE" ]]
}

@test "arr.drop : drop match-size elements" {
  run arr.drop 3 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "" ]]
}

@test "arr.drop : drop over-size elements" {
  run arr.drop 10 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output[@]}"
  [[ "$status" == 0 ]]
  [[ "${output[0]}" == "" ]]
}
