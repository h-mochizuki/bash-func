#!/usr/bin/env bats
# =====================================
#           文字列関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../lib/str
}

@test "str.match == false : empty" {
  run str.match
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "str.match == false : one param" {
  run str.match "regex"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "str.match == false : not equals" {
  run str.match 'abc' "def"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "str.match == true : equals" {
  run str.match 'abc' "abc"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abc' ]
}

@test "str.match == true : groups" {
  run str.match '(.+)-(.+)' "1234-5678"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '1234-5678 1234 5678' ]
}

@test "str.indexOf == -1 : not exists" {
  run str.indexOf "hoge" "piyo"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" -eq -1 ]
}

@test "str.indexOf == 0 : empty" {
  run str.indexOf
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" -eq 0 ]
}

@test "str.indexOf == 1 : exists" {
  run str.indexOf "hoge" "1hoge"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" -eq 1 ]
}

@test "str.indexOf == 3 : stream" {
  run str.indexOf "hoge" <<< "123hoge"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" -eq 3 ]
}

@test "str.contains == false : empty" {
  run str.contains "hoge"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.contains == false : not contains" {
  run str.contains "hoge" "abc"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.contains == true : contains" {
  run str.contains "hoge" <<< "123hoge"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "str.toLower : empty" {
  run str.toLower
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.toLower : HOGEhoge => hogehoge" {
  run str.toLower "HOGEhoge"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "hogehoge" ]
}

@test "str.toUpper : HOGEhoge => HOGEHOGE" {
  run str.toUpper "HOGEhoge"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "HOGEHOGE" ]
}

@test "str.isInteger - false : empty" {
  run str.isInteger
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.isInteger - false : string" {
  run str.isInteger "abcdefg"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.isInteger - false : decimal" {
  run str.isInteger "1.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.isInteger - false : plus" {
  run str.isInteger "+123456"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.isInteger - true : integer" {
  run str.isInteger "123456"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "str.isInteger - true : minus" {
  run str.isInteger "-123456"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "str.isNumber - false : empty" {
  run str.isNumber
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.isNumber - false : string" {
  run str.isNumber "abcdefg"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.isNumber - true : decimal" {
  run str.isNumber "1.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "str.isNumber - false : dot" {
  run str.isNumber "1.2.3"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.isNumber - false : plus" {
  run str.isNumber "+1.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "str.isNumber - true : minus" {
  run str.isNumber "-1.2"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "str.isNumber - true : integer" {
  run str.isNumber "123456"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "str.times : empty" {
  run str.times
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.times : 1 char 5 times" {
  run str.times '1' 5
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '11111' ]
}

@test "str.times : 5 char 5 times" {
  run str.times '12345' 5
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '1234512345123451234512345' ]
}

@test "str.evalstr : empty" {
  run str.evalstr
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.evalstr : text" {
  run str.evalstr 'abcdefg'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abcdefg' ]
}

@test "str.evalstr : variable" {
  VAR_TEST='12345'
  run str.evalstr '${VAR_TEST}'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '12345' ]
}

@test "str.evalstr : script" {
  run str.evalstr '$(echo "abcdefg")'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abcdefg' ]
}

@test "str.evalstr : complex" {
  VAR_TEST='54321'
  run str.evalstr '''\
12345
${VAR_TEST}

$(echo "abcdefg")
$(
  for i in 6 7 8 9 0; do
    echo -n "$i"
  done
)
'''
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == """\
12345
54321

abcdefg
67890""" ]
}

@test "str.evalfile : empty" {
  run str.evalfile
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.evalfile : text" {
  run str.evalfile <<<'abcdefg'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abcdefg' ]
}

@test "str.evalfile : variable" {
  VAR_TEST='12345'
  run str.evalfile <<<'${VAR_TEST}'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '12345' ]
}

@test "str.evalfile : script" {
  run str.evalfile <<<'$(echo "abcdefg")'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abcdefg' ]
}

@test "str.evalfile : complex" {
  VAR_TEST='54321'
  run str.evalfile <<<'''\
12345
${VAR_TEST}

$(echo "abcdefg")
$(
  for i in 6 7 8 9 0; do
    echo -n "$i"
  done
)
'''
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == """\
12345
54321

abcdefg
67890""" ]
}

@test "str.initial : empty" {
  run str.initial
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.initial : 'a' -> 'a'" {
  run str.initial 'a'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'a' ]
}

@test "str.initial : 'abcdefg' -> 'a'" {
  run str.initial 'abcdefg'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'a' ]
}

@test "str.initial : 'ab' 'cd' -> 'a' 'c'" {
  run str.initial 'ab' 'cd'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '''a
c''' ]
}

@test "str.initial : 'ab   cd' -> 'a'" {
  run str.initial 'ab   cd'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'a' ]
}

@test "str.trim : empty" {
  run str.trim
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.trim : '  ab' -> 'ab'" {
  run str.trim '  ab'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'ab' ]
}

@test "str.trim : 'ab  ' -> 'ab'" {
  run str.trim 'ab  '
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'ab' ]
}

@test "str.trim : '  ab  ' -> 'ab'" {
  run str.trim '  ab  '
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'ab' ]
}

@test "str.trim : '  a  b  ' -> 'a  b'" {
  run str.trim '  a  b'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'a  b' ]
}
