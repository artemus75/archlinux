#!/usr/bin/env bash
set -euo pipefail

if (( EUID == 0 )); then
  printf 'Run as your regular user, not root.\n' >&2
  exit 1
fi

sudo pacman -Syu --needed zsh
printf 'Zsh installed. Change your login shell manually after checking /etc/shells:\n'
printf '  chsh -s /usr/bin/zsh\n'
printf 'Oh My Zsh is optional. Review its upstream installer before running it.\n'
printf '  https://github.com/ohmyzsh/ohmyzsh\n'
