# Arch Linux personal setup

This repository documents a personal Arch Linux installation and optional post-install scripts. It is **not** an unattended installer, a supported distribution, or a validated configuration for arbitrary hardware.

## Installation

Start with [the UEFI/Btrfs installation guide](docs/installation-uefi-btrfs.md). The original [Archlinux Setup.md](Archlinux%20Setup.md) is legacy material and must not be executed unchanged. The new guide has not yet passed the planned VM boot tests.

## Post-install scripts

The numbered root scripts install selected workstation components. They are independent, **not** a single ordered bootstrap program. Read each script before running it; some modify system packages or enable services. Arch Linux requires full upgrades rather than partial upgrades. Scripts do not run automatically.

The `AUR/` scripts provide optional, interactive package installation wrappers. AUR packages are community-maintained; review the PKGBUILD and upstream sources before approving a build. Package names and availability have **not** been validated against current repositories.

## Security boundaries and intentional omissions

- Oh My Zsh and Homebrew: no unattended `curl | sh` execution. Review the official installation instructions manually.
- Warp Terminal: no automatic pacman repository or signing-key trust modification. Verify the vendor key fingerprint independently.
- Git setup: repository-local author configuration only; no global/system changes.
- Git commit helper: stage explicitly named paths, no automatic push.
- Some previously installed applications are omitted until their current package source is confirmed. See [package review](docs/package-review.md).
- The VirtualBox Extension Pack binary was removed from the current tree, not from Git history.
- See [SECURITY.md](SECURITY.md) and [repository hygiene](docs/repository-hygiene.md).

## Validation status

**Deferred until cleanup is complete:** real Arch Linux installation tests, package availability checks, shell script execution, and UEFI/LUKS boot validation. GitHub Actions performs static Bash syntax and ShellCheck analysis; a passing lint run does not demonstrate that installations work.

## License

No license has been selected for this repository. Do not assume the contents are available under an open-source license.
