#!/usr/bin/env bats

setup() {
  load "$BATS_TEST_DIRNAME/../lib/ref"
}

@test "ref with no arguments should print usage and return 1" {
  run ref
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ]
  [[ "${output}" =~ "usage: ref <funcname>" ]]
}

@test "ref should display its own definition" {
  run ref ref
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [[ "${output}" =~ "ref() {" ]]
  [[ "${output}" =~ "}" ]]
}

@test "ref should display definition of a sourced function (e.g., arr.join)" {
  # To test this, we need to load lib/arr first
  load "$BATS_TEST_DIRNAME/../lib/arr"
  run ref arr.join
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [[ "${output}" =~ "arr.join() {" ]]
  [[ "${output}" =~ "}" ]]
}

@test "ref should display type for a built-in command (e.g., echo)" {
  run ref echo
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [[ "${output}" =~ "echo is a shell builtin" ]]
}

@test "ref should display type for an external command (e.g., ls)" {
  run ref ls
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 0 ]
  [[ "${output}" =~ "ls is" ]] # Output might vary, e.g., "ls is /bin/ls"
}

@test "ref should display type for a non-existent command" {
  run ref non_existent_command_123
  echo "status: ${status}"
  echo "output: ${output}"
  [ "$status" -eq 1 ] # `type` command returns 1 for not found
  [[ "${output}" =~ "not found" ]]
}