# Package review queue

The following items were present in the historical setup but are **not automatically installed** by the cleaned-up scripts. This is an intentional safety decision, not a claim that they are obsolete.

| Package or component | Review required |
| --- | --- |
| terraform, packer, argocd | Confirm maintained upstream/package source and licensing before reintroducing |
| kubecolor, localsend | Confirm current official repository or AUR package source |
| neofetch, exa, latte-dock, p7zip | Removed from the application list; decide whether replacements are needed |
| Warp Terminal | Independently verify signing key fingerprint and repository instructions |
| Oh My Zsh, Homebrew, Starship | Decide whether optional installers are still desired; avoid unreviewed remote execution |
| Azure Data Studio | Check upstream support lifecycle and whether this application should remain |
| All twelve AUR packages | Confirm package names, maintained PKGBUILDs, upstream authenticity, dependencies and interactive installation |
| VirtualBox | Guest utilities only in the guest script; host setup requires separate hardware-specific review |
| PipeWire | Confirm migration from existing PulseAudio components before installation |

## Final validation plan (after cleanup)

1. Static checks: `bash -n` and ShellCheck on all shell scripts; resolve reported findings.
2. Verify package names and availability with current Arch repositories/AUR, without blindly executing installs.
3. In a disposable UEFI VM, test the Btrfs installation guide both with and without LUKS2; confirm initramfs, GRUB, networking, users and reboot.
4. Test each relevant post-install script twice (idempotency) and verify expected package/service changes.
5. Review supply-chain decisions, GitHub repository security settings and historical secret-scan results before describing the repository as security-reviewed.

This document is a review queue, not a validated package manifest.
