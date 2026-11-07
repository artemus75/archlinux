#!/usr/bin/env bash
set -euo pipefail

# Confirm any PipeWire/PulseAudio migration on an existing workstation.
sudo pacman -Syu --needed pipewire-pulse pipewire-alsa vlc
