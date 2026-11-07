#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed \
  thunderbird thunderbird-i18n-de \
  libreoffice-fresh libreoffice-fresh-de hunspell-de
