#!/usr/bin/env bash
set -euo pipefail

# Use the official pacman repository where available.
sudo pacman -Syu --needed kubectl kubectx

# kubecolor may be sourced from the AUR, depending on current repository availability.
# Avoid unattended AUR builds; inspect the PKGBUILD before installing it.
if command -v kubecolor >/dev/null 2>&1; then
  kubecolor --version
else
  printf 'kubecolor not installed; review its current package source manually.\n'
fi
