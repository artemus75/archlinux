#!/usr/bin/env bash
set -euo pipefail

package="storageexplorer"
if (( EUID == 0 )); then
  printf 'Do not run AUR helpers as root.\n' >&2
  exit 1
fi
if pacman -Qq "$package" >/dev/null 2>&1; then
  printf '%s already installed.\n' "$package"
  exit 0
fi
if ! command -v yay >/dev/null 2>&1; then
  printf 'yay is missing.\n' >&2
  exit 1
fi
printf 'Review the package source and PKGBUILD for %s before installing.\n' "$package"
read -r -p 'Run interactive yay installation? [y/N] ' answer
case "$answer" in
  y|Y|yes|YES) yay -S --needed -- "$package" ;;
  *) printf 'Skipped.\n'; exit 0 ;;
esac
pacman -Qq "$package" >/dev/null
