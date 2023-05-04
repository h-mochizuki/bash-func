#!/usr/bin/env bats
# =====================================
#             評価関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../lib/assert

  # テスト用にフォーマットを変更
  LOG_FORMAT='[%level]%msg'
}

@test "assert.isRoot : root" {
  assert.isWindows && skip "Windowsなのでテストをスキップします"
  run assert.isRoot root
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.isRoot : other" {
  run assert.isRoot other
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "assert.installed : function" {
  run assert.installed assert.installed
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.installed : builtin" {
  run assert.installed type
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.installed : file" {
  run assert.installed wget
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.installed : alias" {
  run assert.installed ls
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "assert.installed : not defined" {
  run assert.installed notdefinedcommand
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "assert.exec : success" {
  run assert.exec true
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${#output}" == 0 ]
}

@test "assert.exec : failure" {
  run assert.exec false
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '[ERROR]!!FAILED!! -exec-> false ' ]
}

@test "assert.yn : empty" {
  run assert.yn <<<''
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "assert.yn y" {
  run assert.yn <<<'y'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "assert.yn yes" {
  run assert.yn <<<'yes'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "assert.yn Yes" {
  run assert.yn <<<'Yes'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "assert.yn n" {
  run assert.yn <<<'n'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "assert.yn other" {
  run assert.yn <<<'other'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "assert.choice empty" {
  run assert.choice
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "assert.password empty" {
  run assert.password
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == 'variable-name is required!' ]
}

@test "assert.password novalue" {
  run assert.password "password_test" <<<''
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'password_test: ' ]
}
