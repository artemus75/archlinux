#!/usr/bin/env bash
set -euo pipefail

# Only packages available in the configured pacman repositories will be installed.
# Terraform/HashiCorp licensing and repository availability must be reviewed separately.
sudo pacman -Syu --needed vagrant helm
printf 'Review terraform, packer and argocd package sources before installing them.\n'
