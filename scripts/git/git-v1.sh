#!/usr/bin/env bash
set -euo pipefail

# Explicit staging avoids committing unrelated files and secrets by accident.
if [[ $# -lt 1 ]]; then
  printf 'Usage: %s <path> [<path> ...]\n' "$0" >&2
  exit 2
fi

git rev-parse --is-inside-work-tree >/dev/null
branch="$(git branch --show-current)"
if [[ -z "$branch" ]]; then
  printf 'Detached HEAD: refusing to push.\n' >&2
  exit 1
fi

git pull --ff-only
git add -- "$@"
git diff --cached --check
git diff --cached --stat
git diff --cached --name-only

if git diff --cached --quiet; then
  printf 'No staged changes.\n'
  exit 0
fi

printf 'Review the staged diff with: git diff --cached\n'
read -r -p 'Commit message (empty cancels): ' message
if [[ -z "$message" ]]; then
  printf 'Cancelled. Changes remain staged for review.\n'
  exit 0
fi

git commit -m "$message"
printf 'Commit created locally on branch %s. Push manually after review.\n' "$branch"
