#!/bin/bash
set -euxCo pipefail
cd "$(dirname "$0")"

REPO_ROOT="$(cd .. && pwd)"
readonly REPO_ROOT
readonly README_FILE="$REPO_ROOT/README.md"
readonly HEADER_FILE="$REPO_ROOT/assets/profile_header.svg"

function usage() {
  cat <<EOF >&2
Description:
    Verify the public content and local assets of the GitHub profile README.

Usage:
    $0

Options:
    --help, -h: print this
EOF
  exit 1
}

function assert_contains() {
  local _expected="$1"
  local _file="$2"

  grep -Fq "$_expected" "$_file"
}

function main() {
  [[ $# -gt 0 ]] && usage

  [[ -s "$README_FILE" ]]
  [[ -s "$HEADER_FILE" ]]
  assert_contains "assets/profile_header.svg" "$README_FILE"
  assert_contains "Kaito Shigyo" "$README_FILE"
  assert_contains "AI coding agents" "$README_FILE"
  assert_contains "https://furedea.com" "$README_FILE"
  assert_contains "https://github.com/furedea/FIRE-Bench" "$README_FILE"
  assert_contains "https://github.com/furedea/swe-conform" "$README_FILE"
  assert_contains "https://github.com/furedea/agent-harness" "$README_FILE"
  assert_contains "<svg" "$HEADER_FILE"
  assert_contains "</svg>" "$HEADER_FILE"
}

main "$@"
