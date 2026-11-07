#!/usr/bin/env bash
set -euo pipefail

# Homebrew is optional on Arch; do not execute a remote script automatically.
if (( EUID == 0 )); then
  printf 'Run as your regular user, not root.\n' >&2
  exit 1
fi

if command -v brew >/dev/null 2>&1; then
  brew --version
  exit 0
fi

printf 'Homebrew is not installed. Review the official Linux instructions first:\n'
printf '  https://docs.brew.sh/Homebrew-on-Linux\n'
printf 'No remote installer has been downloaded or executed.\n'
printf 'Starship is a separate optional package, not installed by this script.\n'
