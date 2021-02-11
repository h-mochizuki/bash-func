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

@test "yml.toEnv : simple comment" {
  run yml.toEnv <<EOS
hoge: # hoge
  piyo: piyo # piyo
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'hoge_piyo="piyo"' ]
}

@test "yml.toEnv : quoted string and comment" {
  run yml.toEnv <<EOS
hoge: # hoge
  piyo: "piyo" # piyo
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'hoge_piyo="piyo"' ]
}

@test "yml.toEnv : many comments" {
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

@test "yml.toEnv : simple value" {
  run yml.toEnv <<EOS
key: value
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'key="value"' ]
}

@test "yml.toEnv : quoted value" {
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
  key3:
    value3: OK!!
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '''parent_key1="value1"
parent_key2="value2"
parent_key3_value3="OK!!"''' ]
}

@test "yml.toEnv : simple array" {
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
  [ "${output}" == '''children[0]="Wendy"
children[1]="Jhon"
children[2]="Michael"
neverland_children[0]="Peter Pan"''' ]
}

@test "yml.toEnv : complex array" {
  run yml.toEnv <<EOS
Children:
  - London:
    - Wendy
    - Jhon
    - Michael
  - Neverland:
    - Peter Pan
Pirates:
  - Neverland:
    - Captain Hook
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '''Children[0]_London[0]="Wendy"
Children[0]_London[1]="Jhon"
Children[0]_London[2]="Michael"
Children[1]_Neverland[0]="Peter Pan"
Pirates[0]_Neverland[0]="Captain Hook"''' ]
}
