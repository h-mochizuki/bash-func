#!/usr/bin/env bats
# =====================================
#           配列操作関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../lib/arr
  TEST_ARRAY=( "ONE" "TWO" "THREE" )
}

@test "arr.join : empty" {
  run arr.join
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.join : one" {
  run arr.join "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE" ]
}

@test "arr.join : one with delimiter" {
  run arr.join -d 'hoge' "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE" ]
}

@test "arr.join : one with prefix and suffix" {
  run arr.join -p '(' -s ')' "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "(ONE)" ]
}

@test "arr.join : with delimiter" {
  run arr.join -d ' or ' "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE or TWO or THREE" ]
}

@test "arr.join : with delimiter, prefix, suffix" {
  run arr.join -d ', ' -p '[' -s ']' "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "[ONE, TWO, THREE]" ]
}

@test "arr.indexOf <= 0 : not exists" {
  run arr.indexOf "ZERO" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" -eq -1 ]
}

@test "arr.indexOf <= ONE : [0]" {
  run arr.indexOf "ONE" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" -eq 0 ]
}

@test "arr.indexOf <= TWO : [1]" {
  run arr.indexOf "TWO" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" -eq 1 ]
}

@test "arr.indexOf <= THREE : [2]" {
  run arr.indexOf "THREE" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" -eq 2 ]
}

@test "arr.hasElement : not exists" {
  run arr.hasElement "ZERO" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "arr.hasElement : exists" {
  run arr.hasElement "ONE" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "arr.contains : not exists" {
  run arr.contains "ZERO" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "arr.contains : exists" {
  run arr.contains "ONE" "${TEST_ARRAY[@]}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "arr.car : empty" {
  run arr.car
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.car : has 1 element" {
  run arr.car "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE" ]
}

@test "arr.car : has more element" {
  run arr.car "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE" ]
}

@test "arr.head : empty" {
  run arr.head
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.head : has 1 element" {
  run arr.head "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE" ]
}

@test "arr.head : has more element" {
  run arr.head "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE" ]
}

@test "arr.cdr : empty" {
  run arr.cdr
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.cdr : has 1 element" {
  run arr.cdr "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.cdr : has more element" {
  run arr.cdr "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "TWO THREE" ]
}

@test "arr.tail : empty" {
  run arr.cdr
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.tail : has 1 element" {
  run arr.cdr "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.tail : has more element" {
  run arr.cdr "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "TWO THREE" ]
}

@test "arr.last : empty" {
  run arr.last
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.last : has 1 element" {
  run arr.last "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE" ]
}

@test "arr.last : has more element" {
  run arr.last "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "THREE" ]
}

@test "arr.take : empty" {
  run arr.take
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == "" ]
}

@test "arr.take : not number" {
  run arr.take "ONE" "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == "" ]
}

@test "arr.take : negative number" {
  run arr.take "ONE" "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == "" ]
}

@test "arr.take : take 1 element" {
  run arr.take 1 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE" ]
}

@test "arr.take : take match-size elements" {
  run arr.take 3 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE TWO THREE" ]
}

@test "arr.take : take over-size elements" {
  run arr.take 10 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "ONE TWO THREE" ]
}

@test "arr.drop : empty" {
  run arr.drop
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == "" ]
}

@test "arr.drop : not number" {
  run arr.drop "ONE" "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == "" ]
}

@test "arr.drop : negative number" {
  run arr.drop "ONE" "ONE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == "" ]
}

@test "arr.drop : drop 1 element" {
  run arr.drop 1 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "TWO THREE" ]
}

@test "arr.drop : drop 2 element" {
  run arr.drop 2 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "THREE" ]
}

@test "arr.drop : drop match-size elements" {
  run arr.drop 3 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.drop : drop over-size elements" {
  run arr.drop 10 "ONE" "TWO" "THREE"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.uniq : empty" {
  run arr.uniq
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "" ]
}

@test "arr.uniq : one" {
  run arr.uniq 1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "1" ]
}

@test "arr.uniq : two" {
  run arr.uniq 1 2
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "1
2" ]
}

@test "arr.uniq : duplicate" {
  run arr.uniq 1 1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "1" ]
}

@test "arr.uniq : words-1" {
  run arr.uniq "I" "love" "you"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "I
love
you" ]
}

@test "arr.uniq : words-2" {
  run arr.uniq "I" "sed" "Oops ..." "and" "Oops ..."
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "I
sed
Oops ...
and" ]
}

@test "arr.excludes : no option" {
  run arr.excludes "I" "sed" "Oops ..." "and" "Oops ..."
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "I
sed
Oops ...
and
Oops ..." ]
}

@test "arr.excludes : exclude-1" {
  run arr.excludes -i "sed" "I" "sed" "Oops ..." "and" "Oops ..."
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "I
Oops ...
and
Oops ..." ]
}

@test "arr.excludes : exclude-2" {
  run arr.excludes -i "sed" -i "and" "I" "sed" "Oops ..." "and" "Oops ..."
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "I
Oops ...
Oops ..." ]
}

@test "arr.excludes : from input-stream" {
  run arr.excludes -i "sed" <<<"""I
sed
Oops ...
and
Oops ..."""
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "I
Oops ...
and
Oops ..." ]
}

