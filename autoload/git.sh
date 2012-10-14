#!/bin/bash

__git_ps1 ()
{
	local g="$(git rev-parse --git-dir 2>/dev/null)"
	if [ -n "$g" ]; then
		local r
		local b
		if [ -d "$g/rebase-apply" ]
		then
			if test -f "$g/rebase-apply/rebasing"
			then
				r="|REBASE"
			elif test -f "$g/rebase-apply/applying"
			then
				r="|AM"
			else
				r="|AM/REBASE"
			fi
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		elif [ -f "$g/rebase-merge/interactive" ]
		then
			r="|REBASE-i"
			b="$(cat "$g/rebase-merge/head-name")"
		elif [ -d "$g/rebase-merge" ]
		then
			r="|REBASE-m"
			b="$(cat "$g/rebase-merge/head-name")"
		elif [ -f "$g/MERGE_HEAD" ]
		then
			r="|MERGING"
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		else
			if [ -f "$g/BISECT_LOG" ]
			then
				r="|BISECTING"
			fi
			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
			then
				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"
				then
					b="$(cut -c1-7 "$g/HEAD")..."
				fi
			fi
		fi

		local w
		local i

		if test -n "${GIT_PS1_SHOWDIRTYSTATE-}"; then
			if test "$(git config --bool bash.showDirtyState)" != "false"; then
				git diff --no-ext-diff --ignore-submodules \
					--quiet --exit-code || w="*"
				if git rev-parse --quiet --verify HEAD >/dev/null; then
					git diff-index --cached --quiet \
						--ignore-submodules HEAD -- || i="+"
				else
					i="#"
				fi
			fi
		fi

		if [ -n "${1-}" ]; then
			printf "$1" "${b##refs/heads/}$w$i$r"
		else
			printf " (%s)" "${b##refs/heads/}$w$i$r"
		fi
	fi
}

function gull() {
  branch=`__git_ps1 "%s"`
  if [[ -z "$1" ]]; then
    remote=`git config branch.$branch.remote`
    if [[ -z "$remote" ]]; then
      remote=origin
    fi
  else
    remote="$1"
  fi
  echo git pull "$remote" "$branch"
  git pull "$remote" "$branch"
}

function gush() {
  branch=`__git_ps1 "%s"`
  if [[ -z "$1" ]]; then
    remote=`git config branch.$branch.remote`
    if [[ -z "$remote" ]]; then
      remote=origin
    fi
  else
    remote="$1"
  fi
  echo git push "$remote" "$branch"
  git push "$remote" "$branch"
}

function gpp() {
  gull $@ && gush $@
}
