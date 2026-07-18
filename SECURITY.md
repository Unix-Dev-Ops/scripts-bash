# Security Policy

## Supported versions

Only the latest commit on `main` is supported.

## Reporting a vulnerability

**Do not** open a public GitHub issue for security-sensitive reports.

Email or DM the maintainer privately:

- GitHub: [@Unix-Dev-Ops](https://github.com/Unix-Dev-Ops)

Include:

- Description of the issue
- Steps to reproduce (if safe)
- Impact assessment

You should receive an acknowledgment when the maintainer is available. Please allow reasonable time before any public disclosure.

## Out of scope

- Issues that only exist in *consumers’* private installer products built *with* this skill (those are not this repo)
- Social engineering of maintainer accounts

## Secrets

This repository must never contain API keys, tokens, passphrases, or private `.env` files. PRs that add secrets will be rejected and history may be force-cleaned if needed.
