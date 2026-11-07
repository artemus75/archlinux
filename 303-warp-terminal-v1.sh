#!/usr/bin/env bash
set -euo pipefail

# Third-party package repository and key trust require explicit manual review.
# This script does not modify pacman.conf or trust a remote signing key.
if pacman -Qq warp-terminal >/dev/null 2>&1; then
  printf 'warp-terminal is already installed.\n'
  exit 0
fi

printf 'Warp Terminal is not installed.\n'
printf 'Review the current official Linux installation instructions and verify\n'
printf 'the repository signing-key fingerprint independently before configuring pacman.\n'
printf '  https://docs.warp.dev/getting-started/getting-started-with-warp\n'
printf 'No repository, key or package has been installed automatically.\n'
