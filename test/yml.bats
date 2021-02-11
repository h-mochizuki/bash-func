#!/usr/bin/env bats
# =====================================
#        YAMLファイル変換関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../lib/yml
}

@test "yml.toEnv : empty" {
  run yml.toEnv
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "yml.toEnv : line comment" {
  run yml.toEnv <<EOS
# hoge
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "yml.toEnv : eol comment1" {
  run yml.toEnv <<EOS
hoge: # hoge
  piyo: piyo # piyo
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'hoge_piyo="piyo"' ]
}

@test "yml.toEnv : eol comment2 : quoted" {
  run yml.toEnv <<EOS
hoge: # hoge
  piyo: "piyo" # piyo
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'hoge_piyo="piyo"' ]
}

@test "yml.toEnv : eol comment3 : many times" {
  run yml.toEnv <<EOS
hoge: # hoge
  piyo: "piyo # piyo" # piyo # piyo
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'hoge_piyo="piyo # piyo"' ]
}

@test "yml.toEnv : only key" {
  run yml.toEnv <<EOS
key:
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "yml.toEnv : one line" {
  run yml.toEnv <<EOS
key: value
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'key="value"' ]
}

@test "yml.toEnv : one line2 : quoted" {
  run yml.toEnv <<EOS
key: "value"
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'key="value"' ]
}

@test "yml.toEnv : multi line" {
  run yml.toEnv <<EOS
key1: value1
key2: value2
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '''key1="value1"
key2="value2"''' ]
}

@test "yml.toEnv : associative array" {
  run yml.toEnv <<EOS
parent:
  key1: value1
  key2: value2
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '''parent_key1="value1"
parent_key2="value2"''' ]
}

@test "yml.toEnv : array" {
  run yml.toEnv <<EOS
children:
  - Wendy
  - Jhon
  - Michael
neverland:
  children:
    - Peter Pan
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '''children[1]="Wendy"
children[2]="Jhon"
children[3]="Michael"
neverland_children[1]="Peter Pan"''' ]
}
