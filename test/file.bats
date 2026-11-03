#!/usr/bin/env bats
# =====================================
#             評価関数テスト
# =====================================

setup() {
  load $BATS_TEST_DIRNAME/../lib/file
  EXECUTABLE_FILE="${BATS_TMPDIR}/execfile"
  echo "${EXECUTABLE_FILE}" > "${EXECUTABLE_FILE}"
  chmod +x "${EXECUTABLE_FILE}"
  NOTEXECUTABLE_FILE="${BATS_TMPDIR}/notexecfile"
  echo "${NOTEXECUTABLE_FILE}" > "${NOTEXECUTABLE_FILE}"
}

teardown() {
  if [ ! -z "${EXECUTABLE_FILE+x}" ];then
    rm -f "${EXECUTABLE_FILE}"
  fi
  if [ ! -z "${NOTEXECUTABLE_FILE+x}" ];then
    rm -f "${NOTEXECUTABLE_FILE}"
  fi
}

@test "file.executable : empty" {
  run file.executable
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "file.executable : executable" {
  run file.executable "${EXECUTABLE_FILE}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
}

@test "file.executable : not executable" {
  run file.executable "${NOTEXECUTABLE_FILE}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
}

@test "file.isBelongedTo : empty" {
  run file.isBelongedTo
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "file.isBelongedTo : not found" {
  run file.isBelongedTo "hogehogepiyopiyo"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "file.isBelongedTo file.bats" {
  pushd "${BATS_TEST_DIRNAME}"
  run file.isBelongedTo "file.bats"
  popd
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "${BATS_TEST_DIRNAME}/file.bats" ]
}

@test "file.isBelongedTo $(basename ${BATS_TEST_DIRNAME})" {
  parent="$(basename ${BATS_TEST_DIRNAME})"
  run file.isBelongedTo "${parent}"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == "${BATS_TEST_DIRNAME}" ]
}

@test "file.isSame : empty" {
  run file.isSame
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "file.isSame : 1 param only" {
  pushd "${BATS_TEST_DIRNAME}"
  run file.isSame "file.bats"
  popd
  [ "$status" -eq 1 ]
  [ "${output}" == '' ]
}

@test "file.isSame : same file" {
  pushd "${BATS_TEST_DIRNAME}"
  run file.isSame "file.bats" "file.bats"
  popd
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "file.isSame : same dir" {
  run file.isSame "${BATS_TEST_DIRNAME}" "${BATS_TEST_DIRNAME}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "file.isSame : from file not found" {
  pushd "${BATS_TEST_DIRNAME}"
  run file.isSame "file1.bats" "file.bats"
  popd
  [ "$status" -eq 2 ]
  [ "${output}" == '' ]
}

@test "file.isSame : target file not found" {
  pushd "${BATS_TEST_DIRNAME}"
  run file.isSame "file.bats" "file2.bats"
  popd
  [ "$status" -eq 2 ]
  [ "${output}" == '' ]
}

@test "file.isSame : targetdirectory not found" {
  run file.isSame "${BATS_TEST_DIRNAME}" "${BATS_TEST_DIRNAME}hogehogepiyopiyo"
  [ "$status" -eq 1 ]
  [[ "${output}" =~ md5sum.*$ ]]
}

@test "file.isSame : targetdirectory not match" {
  run file.isSame "${BATS_TEST_DIRNAME}" "/tmp"
  [ "$status" -eq 1 ]
  [[ "${output}" =~ md5sum.*$ ]]
}

@test "file.eval : empty" {
  run file.eval
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '' ]
}

@test "file.eval : text" {
  run file.eval <<<'abcdefg'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abcdefg' ]
}

@test "file.eval : variable" {
  VAR_TEST='12345'
  run file.eval <<<'${VAR_TEST}'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '12345' ]
}

@test "file.eval : script" {
  run file.eval <<<'$(echo "abcdefg")'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'abcdefg' ]
}

@test "file.eval : complex" {
  VAR_TEST='54321'
  run file.eval <<<'''\
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

# ----------------
#  - を標準入力とみなす（Unix 互換）
# ----------------
@test "file.stream : - を標準入力として読む" {
  run file.stream - <<< 'pipe'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'pipe' ]
}

@test "file.stream : ファイルと - を指定順に連結する" {
  local f="${BATS_TEST_TMPDIR}/a.txt"
  echo 'file' > "$f"
  run file.stream "$f" - <<< 'pipe'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'file
pipe' ]
}

@test "file.stream : - とファイルを指定順に連結する" {
  local f="${BATS_TEST_TMPDIR}/a.txt"
  echo 'file' > "$f"
  run file.stream - "$f" <<< 'pipe'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'pipe
file' ]
}

@test "file.eval : - を標準入力として読む" {
  run file.eval - <<< '$((1 + 2))'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == '3' ]
}

@test "file.eachLine : ファイル未指定の場合は標準入力を読む" {
  run file.eachLine <<< 'a b
c'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'a b
c' ]
}

@test "file.eachLine : ファイルと - を指定順に連結する" {
  local f="${BATS_TEST_TMPDIR}/a.txt"
  echo 'file' > "$f"
  run file.eachLine "$f" - <<< 'pipe'
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'file
pipe' ]
}

@test "file.eachLine : 空白を含むファイル名" {
  local f="${BATS_TEST_TMPDIR}/a b.txt"
  echo 'file' > "$f"
  run file.eachLine "$f"
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [ "${output}" == 'file' ]
}
