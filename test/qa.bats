#!/usr/bin/env bats
# =====================================
#             質問関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../lib/qa

  # テスト用にフォーマットを変更
  LOG_FORMAT='[%level]%msg'
}

@test "qa.yn : empty" {
  run qa.yn <<<''
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "qa.yn y" {
  run qa.yn <<<'y'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "qa.yn yes" {
  run qa.yn <<<'yes'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "qa.yn Yes" {
  run qa.yn <<<'Yes'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  run qa.yn <<<'y'
  [ "${output}" == '' ]
}

@test "qa.yn n" {
  run qa.yn <<<'n'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "qa.yn other" {
  run qa.yn <<<'other'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "qa.checkbox empty" {
  run qa.checkbox
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "qa.password empty" {
  run qa.password
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == 'variable-name is required!' ]
}

@test "qa.password novalue" {
  run qa.password "password_test" <<<''
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'password_test: ' ]
}
