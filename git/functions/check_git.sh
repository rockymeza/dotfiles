#!/usr/bin/env bash
#--------------------------------------------------
#    Checks if PWD is inside a git working tree
#--------------------------------------------------
check_git() {
  test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true
}
