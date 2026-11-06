#!/usr/bin/env bash
set -euo pipefail

# AUR packages are user-built and are not supported by Arch Linux.
# Inspect the PKGBUILD and related files before invoking makepkg.

if (( EUID == 0 )); then
  printf 'Do not build AUR packages as root.\n' >&2
  exit 1
fi

if command -v yay >/dev/null 2>&1; then
  yay --version
  exit 0
fi

sudo pacman -S --needed base-devel git

aur_dir="${XDG_CACHE_HOME:-$HOME/.cache}/archlinux-setup/aur"
mkdir -p "$aur_dir"

if [[ ! -d "$aur_dir/yay/.git" ]]; then
  if [[ -e "$aur_dir/yay" ]]; then
    printf 'Refusing to overwrite existing non-git path: %s\n' "$aur_dir/yay" >&2
    exit 1
  fi
  git clone https://aur.archlinux.org/yay.git "$aur_dir/yay"
fi

cd "$aur_dir/yay"
git fetch --ff-only origin
git merge --ff-only origin/HEAD
printf '\nReview PKGBUILD and all build/install scripts in %s before continuing.\n' "$PWD"
printf 'No package has been built or installed automatically.\n'
printf 'After review, run manually: cd %q && makepkg -si\n' "$PWD"
