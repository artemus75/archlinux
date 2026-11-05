# Repository hygiene — phase 1

This is a public personal Arch Linux setup, not an audited or supported installer. No commands from this repository should be executed blindly.

## Confirmed inventory (2026-11-05)

- Default branch: `main`; the hygiene changes are isolated on `chore/phase-1-repository-hygiene`.
- 14 numbered root setup scripts, 12 scripts under `AUR/`, two Git helper scripts, one installation guide and a minimal README.
- `Oracle_VirtualBox_Extension_Pack-7.1.4.vbox-extpack` was tracked at the repository root (22,966,826 bytes). It is removed from the proposed tree, **not** from Git history.
- No root license was found. **No open-source license has been granted by this cleanup**; a license choice remains an explicit maintainer decision.
- The public rulesets API returned an empty array. Branch-protection details could not be accessed (GitHub App returned 403); this does **not** prove there is no protection.
- A complete historical secret scan has **not** been executed: GitHub access in this environment does not provide a local clone or access to private security alerts.

## Third-party software and trust boundaries

| File | Existing behavior | Required treatment before execution |
| --- | --- | --- |
| `110-zsh-v1.sh` | Executes the Oh My Zsh installer downloaded with curl | Inspect upstream content and use a verified revision; avoid unreviewed execution |
| `160-homebrew-v1.sh` | Executes the Homebrew installer downloaded with curl | Verify official source and review script before execution |
| `303-warp-terminal-v1.sh` | Appends a third-party pacman repository and locally signs a retrieved key | Verify the signing key fingerprint independently, prevent duplicate repository entries and review vendor instructions |
| `150-yay-v1.sh` | Clones AUR helper and runs makepkg | Review PKGBUILD and build instructions |
| `330-kubectl-v1.sh` and `AUR/*.sh` | Installs packages with yay, frequently `--noconfirm` | Check whether official Arch packages are available; review PKGBUILDs and remove unattended AUR approval |

These behaviors are **findings, not remediated script changes**. They are tracked in issue #3 and belong in the subsequent script modernization.

## Local historical secrets audit (still required)

Run on a trusted workstation with a fresh full clone and an independently installed Gitleaks binary:

```bash
git clone --mirror https://github.com/artemus75/archlinux.git archlinux-audit.git
cd archlinux-audit.git
gitleaks git --redact --report-format json --report-path ../archlinux-gitleaks-report.json .
```

Check the Gitleaks version's supported command syntax first. Keep the report **outside the public repository** and do not commit it. Investigate all findings and rotate any confirmed leaked credentials; never treat a clean pattern scan as proof of absence. GitHub secret-scanning alerts should also be reviewed privately under the repository's Security tab.

## GitHub security configuration

The public rulesets listing was empty. The branch protection API returned 403 for this connection. The repository owner should verify default branch protections, secret scanning alerts and push protection under GitHub Settings/Security. Existing repositories may have different defaults than newly created ones.

## Vendor binary licensing

Oracle publishes VirtualBox Extension Packs on its official download page: https://www.virtualbox.org/wiki/Downloads . The Extension Pack is separately licensed; do not redistribute a downloaded binary without verifying the applicable license. Obtain a version matching the installed VirtualBox release.

## Remaining decisions

1. Whether a full history rewrite is needed for the removed binary; avoid a destructive rewrite unless justified and coordinated.
2. The open-source license, if any, to grant for original scripts and documentation.
3. Security settings requiring owner/admin access.
4. Local historical secret scan results.

See issues #1–#5. Phase 1 can be merged as a **baseline cleanup**, but the above outstanding checks must not be represented as completed.
