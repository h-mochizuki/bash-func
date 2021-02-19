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

@test "yml.toEnv : dot key" {
  run yml.toEnv <<EOS
key.1: value
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'key_1="value"' ]
}

@test "yml.toEnv : hyphen key" {
  run yml.toEnv <<EOS
key-1: value
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'key_1="value"' ]
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

@test "yml.toEnv : nested array" {
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

@test "yml.toEnv : complex array" {
  run yml.toEnv <<EOS
Member:
  - name: Sato
    age: 20
    favalid:
      - Beer
  - name: Suzuki
    age: 25
    favalid:
      - Wine
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '''Member[0]_name="Sato"
Member[0]_age="20"
Member[0]_favalid[0]="Beer"
Member[1]_name="Suzuki"
Member[1]_age="25"
Member[1]_favalid[0]="Wine"''' ]
}

@test "yml.toProperties : empty" {
  run yml.toProperties
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "yml.toProperties : simple value" {
  run yml.toProperties <<EOS
key: value
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'key=value' ]
}

@test "yml.toProperties : dot key" {
  run yml.toProperties <<EOS
key.1: value
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'key.1=value' ]
}

@test "yml.toProperties : complex array" {
  run yml.toProperties <<EOS
Member:
  - name: Sato
    age: 20
    favorite:
      - Sake
      - Beer
  - name: Suzuki
    age: 25
    favorite:
      - Wine
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '''Member.0.name=Sato
Member.0.age=20
Member.0.favorite.0=Sake
Member.0.favorite.1=Beer
Member.1.name=Suzuki
Member.1.age=25
Member.1.favorite.0=Wine''' ]
}

@test "yml.grep : empty" {
  run yml.grep
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "yml.grep : list" {
  run yml.grep name <<EOS
Member:
  - name: Sato
    age: 20
    favorite:
      - Sake
      - Beer
  - name: Suzuki
    age: 25
    favorite:
      - Wine
EOS
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '''Member.0.name=Sato
Member.1.name=Suzuki''' ]
}
