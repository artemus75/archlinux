# Repository hygiene — phase 1

This repository is a public record of a personal Arch Linux setup, not a general-purpose installation framework.

## Initial findings (2026-11-05)

- A VirtualBox Extension Pack 7.1.4 binary (~22.97 MB) was tracked at repository root. It is removed from the phase-1 branch; the historical Git blob remains reachable until any separately approved history rewrite.
- No root LICENSE was present. A license should be chosen deliberately after confirming rights and intended reuse; none is assumed in this phase.
- Root README is minimal; substantive documentation improvements are deferred.
- Several scripts run upstream installers or configure external package trust. See the supply-chain issue.
- The current tracked files have been inspected for obvious credential patterns, but **no comprehensive historical secrets scan has been completed**. See the history-audit issue.

## VirtualBox Extension Pack

Obtain the extension pack only from the [official VirtualBox downloads page](https://www.virtualbox.org/wiki/Downloads) and check its license and compatibility with the installed VirtualBox version before installation. It is not needed for every VirtualBox setup.

## Follow-up

See the phase-1 GitHub issues for history/secret scanning, license decision, external installer review and repository security settings. Do not rewrite Git history without assessing consequences for existing clones and forks.
