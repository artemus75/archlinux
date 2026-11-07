#!/usr/bin/env bash
set -euo pipefail

if (( EUID == 0 )); then
  printf 'Run as your regular user, not root.\n' >&2
  exit 1
fi

printf 'Git configuration scope: local repository only.\n'
git rev-parse --is-inside-work-tree >/dev/null || {
  printf 'Run inside an existing Git repository. No git init performed.\n' >&2
  exit 1
}

read -r -p 'Commit author name (empty skips): ' author_name
read -r -p 'Commit author email (empty skips): ' author_email

if [[ -n "$author_name" ]]; then
  git config --local user.name "$author_name"
fi
if [[ -n "$author_email" ]]; then
  git config --local user.email "$author_email"
fi

printf 'Local repository author settings updated.\n'
printf 'Credential helpers, global configuration and system editor remain unchanged.\n'
