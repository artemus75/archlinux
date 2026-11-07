# Deferred validation checklist

**Status:** Not started. The maintainer requested validation only after all repository cleanup is merged. Do not interpret static lint or a merged PR as a successful installation test.

## 1. Static quality gate

- [ ] GitHub Actions ShellCheck workflow passes on the final `main` commit.
- [ ] All scripts pass `bash -n` and ShellCheck; inspect any suppression individually.
- [ ] Check all relative paths and README references after the relocation.
- [ ] Review scripts for unintended system changes, hardcoded usernames, unattended AUR execution and insecure remote installers.

## 2. Package and source audit

- [ ] Confirm every `pacman` package against current Arch repositories and current packaging policies.
- [ ] Confirm all AUR names, maintenance status, upstream authenticity and PKGBUILD contents.
- [ ] Resolve [package review](package-review.md), including Terraform/Packer/Argo CD, Warp and retired packages.
- [ ] Ensure full upgrades are performed deliberately; never use partial upgrades.

## 3. Disposable UEFI VM: base installation

- [ ] UEFI/GPT with new ESP at `/boot` and unencrypted Btrfs root: install, reboot, log in, networking works.
- [ ] Repeat with LUKS2 root; verify `sd-encrypt`, kernel command line, passphrase prompt and Btrfs root subvolume.
- [ ] Inspect `fstab`, initramfs, GRUB, mountpoints, locale, timezone, users and permissions.
- [ ] Record test environment, Arch ISO date, kernel, commands, deviations and results.
- [ ] Update installation guide for verified corrections.

## 4. Post-install tests

- [ ] Run each relevant script in a disposable VM or snapshot-based test environment.
- [ ] Run a second time to assess idempotency and detect duplicate config entries or side effects.
- [ ] Verify service activation, desktop session and installed tools.
- [ ] Confirm AUR wrappers request explicit consent and do not run as root.
- [ ] Check that optional external installers and Git helpers respect their documented safety boundaries.

## 5. Security and publication decisions

- [ ] Complete full Git-history secret scan and privately investigate findings.
- [ ] Review repository settings, secret scanning and branch protection with owner permissions.
- [ ] Decide license and third-party redistribution rights.
- [ ] Resolve remaining issues #1–#5 where evidence permits.

Document results in a follow-up PR; do not close open security or boot-validation issues without evidence.
