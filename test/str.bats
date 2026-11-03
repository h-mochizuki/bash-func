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

@test "str.take : empty args" {
  run str.take
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "str.take : arg is not number" {
  run str.take "na"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == 'na' ]
}

@test "str.take : empty string" {
  run str.take 5
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.take 5 : '1234567890' -> '12345'" {
  run str.take 5 '1234567890'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '12345' ]
}

@test "str.take -5 : '1234567890' -> '67890'" {
  run str.take -5 '1234567890'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '67890' ]
}

@test "str.take 0 : '1234567890' -> ''" {
  run str.take 0 '1234567890'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.fill : empty" {
  run str.fill
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "str.fill : not number" {
  run str.fill "hoge"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "str.fill 5 : -> '     '" {
  run str.fill 5
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '     ' ]
}

@test "str.fill 5 ' ' : 'a' -> 'a    '" {
  run str.fill 5 ' ' 'a'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'a    ' ]
}

@test "str.fill 5 ' ' : 'abc' -> 'abc  '" {
  run str.fill 5 ' ' 'abc'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abc  ' ]
}

@test "str.fill 5 '0' : 'abc' -> 'abc00'" {
  run str.fill 5 '0' 'abc'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abc00' ]
}

@test "str.fill -5 ' ' : 'a' -> '    a'" {
  run str.fill -5 ' ' 'a'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '    a' ]
}

@test "str.fill -5 '0' : 'abc' -> '00abc'" {
  run str.fill -5 '0' 'abc'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '00abc' ]
}

@test "str.base64 : empty" {
  run str.base64
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.base64 : 'abcあいう' -> 'YWJj44GC44GE44GG'" {
  run str.base64 'abcあいう'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'YWJj44GC44GE44GG' ]
}

@test "str.base64 -d : empty" {
  run str.base64 -d
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "str.base64 -d : 'YWJj44GC44GE44GG' -> 'abcあいう'" {
  run str.base64 -d 'YWJj44GC44GE44GG'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abcあいう' ]
}

@test "str.hr" {
  run str.hr
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [[ "${output}" =~ ^-+$ ]]
}

@test "str.hr '='" {
  run str.hr '='
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [[ "${output}" =~ ^=+$ ]]
}

@test "str.rect" {
  run str.rect
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '--------------------
|                  |
|                  |
|                  |
|                  |
|                  |
|                  |
|                  |
|                  |
|                  |
--------------------' ]
}

@test "str.rect 1" {
  run str.rect 1
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '-' ]
}

@test "str.rect 3 5" {
  run str.rect 3 5
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '---
| |
| |
| |
---' ]
}

@test "str.rect 5 3" {
  run str.rect 5 3
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '-----
|   |
-----' ]
}

@test "str.trim -n : while-read ループ内で -n を指定すれば入力ストリームを読まない" {
  run bash -c "source '$BATS_TEST_DIRNAME/../lib/str'; printf 'l1\nl2\n' | while read -r l; do str.trim -n \"  \${l}  \"; done"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'l1
l2' ]
}

@test "str.toUpper : 引数と入力ストリームの両方がある場合は引数の後に入力ストリームを出力する" {
  run bash -c "source '$BATS_TEST_DIRNAME/../lib/str'; echo 'pipe' | str.toUpper 'arg'"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'ARG
PIPE' ]
}

@test "str.toUpper -n : 入力ストリームを読まない" {
  run bash -c "source '$BATS_TEST_DIRNAME/../lib/str'; echo 'pipe' | str.toUpper -n 'arg'"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'ARG' ]
}

@test "str.indexOf : 入力文字列と入力ストリームの両方がある場合は入力文字列を優先する" {
  run bash -c "source '$BATS_TEST_DIRNAME/../lib/str'; echo 'zzzhoge' | str.indexOf 'hoge' '1hoge'"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" -eq 1 ]
}

@test "str.base64 : 入力ストリーム" {
  run str.base64 <<< 'abc'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'YWJjCg' ]
}

@test "str.evalfile : - を標準入力として読む" {
  run str.evalfile - <<< '$((1 + 2))'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '3' ]
}

# ----------------
#  引数と入力ストリームの併用
# ----------------
@test "str.stream : 引数の後に入力ストリームを出力する" {
  run str.stream 'arg1' 'arg2' <<< 'pipe'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'arg1 arg2
pipe' ]
}

@test "str.stream -n : 入力ストリームを読まない" {
  run str.stream -n 'arg' <<< 'pipe'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'arg' ]
}

@test "str.stream : 入力ストリームが空なら引数だけを出力する（余分な空行を出さない）" {
  run bash -c "source '$BATS_TEST_DIRNAME/../lib/str'; printf '' | str.stream 'arg' | wc -l"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" -eq 1 ]
}

@test "str.stream : /dev/null は読まない" {
  run str.stream 'arg' < /dev/null
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'arg' ]
}

@test "str.stream : echo のオプションと同じ文字列も出力できる" {
  run str.stream -n '-e'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '-e' ]
}

@test "str.initial : 引数の後に入力ストリームを1行ずつ処理する" {
  run str.initial 'ab' 'cd' <<< 'ef'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'a
c
e' ]
}

@test "str.trim : 引数の後に入力ストリームを処理する" {
  run str.trim '  ab  ' <<< '  cd  '
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'ab
cd' ]
}

@test "str.take -n : 入力ストリームを読まない" {
  run str.take -n 3 '12345' <<< 'abcde'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '123' ]
}

@test "str.take : 引数の後に入力ストリームを処理する" {
  run str.take 3 '12345' <<< 'abcde'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '123
abc' ]
}

@test "str.fill -n : 入力ストリームを読まない" {
  run str.fill -n 5 '0' 'abc' <<< 'xyz'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abc00' ]
}
