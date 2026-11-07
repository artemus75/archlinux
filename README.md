# Arch Linux — personal setup

This repository records a personal Arch Linux workstation installation. It is **not** an unattended installer, a supported distribution, or a hardware-independent setup. Review scripts before executing them.

## Repository layout

| Path | Purpose |
| --- | --- |
| [docs/installation-uefi-btrfs.md](docs/installation-uefi-btrfs.md) | UEFI, Btrfs and optional LUKS2 base installation; **not boot-tested yet** |
| [scripts/post-install/](scripts/post-install/) | Optional system, desktop and application setup scripts |
| [scripts/aur/](scripts/aur/) | Optional interactive AUR package wrappers |
| [scripts/git/](scripts/git/) | Repository-local Git setup and explicit-staging commit helper |
| [docs/package-review.md](docs/package-review.md) | Deferred package-source decisions and final validation checklist |
| [docs/repository-hygiene.md](docs/repository-hygiene.md) | Security/hygiene review and outstanding actions |
| [SECURITY.md](SECURITY.md) | Security reporting guidance |

The older [Archlinux Setup.md](Archlinux%20Setup.md) remains only for historical reference; do not follow it as-is.

## Suggested sequence

1. Read the [base installation guide](docs/installation-uefi-btrfs.md) and adapt it to the target hardware. It is unvalidated.
2. Review the individual scripts in `scripts/post-install/` before running any. They are **optional**, not a single automated installer. Their numeric prefixes are a historical grouping, not a guaranteed dependency order.
3. For AUR software, inspect package sources and PKGBUILDs; then run only the desired wrapper in `scripts/aur/`. Never run AUR helpers as root.
4. Git helper scripts are separate and optional; they do not automatically push or modify system-wide Git settings.

Example **inspection only**:

```bash
sed -n '1,200p' scripts/post-install/100-network-v1.sh
bash -n scripts/post-install/100-network-v1.sh
```

## Safety and validation

- Package installs and system-service changes can affect a running workstation. Back up first.
- External installer scripts (Oh My Zsh, Homebrew) and the Warp signing-key setup are **not automatically executed**.
- Some former application packages remain excluded until their current sources are reviewed.
- CI performs `bash -n` and ShellCheck for all `scripts/**/*.sh`. This is static checking only.
- **All practical validation is deferred until cleanup is complete:** UEFI VM boot tests (with/without LUKS), package availability, actual script execution and idempotency.
- Repository history secret scanning, admin security settings and licensing are still separate open decisions. No open-source license has been granted.

See [the validation checklist](docs/validation-checklist.md) for the later test campaign.
