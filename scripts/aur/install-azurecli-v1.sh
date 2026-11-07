#!/usr/bin/env bash
set -euo pipefail

# Package source and PKGBUILD must be reviewed before installing.
# This script never bypasses confirmation prompts.
package="azure-cli"

if (( EUID == 0 )); then
  printf 'Do not run AUR helpers as root.\n' >&2
  exit 1
fi

if pacman -Qq "$package" >/dev/null 2>&1; then
  printf '%s is already installed.\n' "$package"
  exit 0
fi

if ! command -v yay >/dev/null 2>&1; then
  printf 'yay is missing. Review and install an AUR helper first.\n' >&2
  exit 1
fi

printf 'Review the package source and PKGBUILD for %s before proceeding.\n' "$package"
printf 'Package availability and maintenance status have not been validated.\n'
read -r -p 'Run interactive yay installation? [y/N] ' answer
case "$answer" in
  y|Y|yes|YES) yay -S --needed -- "$package" ;;
  *) printf 'Skipped %s.\n' "$package"; exit 0 ;;
esac

pacman -Qq "$package" >/dev/null
printf '%s installed.\n' "$package"
