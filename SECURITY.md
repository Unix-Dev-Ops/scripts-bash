# Security Policy

## Scope

This repository ships **templates and guidance**, not a running service: one bash
template, a variable registry, and an authoring guide. The threat model is therefore
what the code here *teaches or recommends*, not what it exposes over a network.

## Reporting a vulnerability

Open a **private security advisory** on this repository: Security tab -> *Report a
vulnerability*. It is not public, no issue is created, and you stay anonymous if you
want. There is no email address for this project.

- Acknowledged within **14 days** (single maintainer, not a team).
- The fix lands as an ordinary commit on `main`. This project does not rewrite history.
- No fixed public-disclosure window is promised. Ask, and we'll agree on one.

## What counts as a vulnerability here

Anything the template would let a script do with input it did not author:

- Unquoted parameter expansion or `IFS` manipulation that turns data into words or flags.
- `eval`, `source` of an attacker-controlled path, or command substitution over untrusted input.
- `rm -rf "$VAR"/` and globbing against a variable that may be unset or empty.
- Temp files, lock files, or logs written to world-writable paths, where a symlink can win.
- Credentials, tokens, hostnames, or internal paths embedded in script text, arguments, or committed logs.
- `curl ... | bash` and downloads over plaintext or from unpinned digests.
- Sourcing `.env` or config from a directory another user controls.
- `trap` handlers that perform privileged cleanup or leak environment state.

## Out of scope

- Bugs in your own private installers — this repo has no visibility into them.
- Anything that already assumes the attacker has a shell on the target host.
- Resource exhaustion / denial of service.

## What is enforced before merge

- CI runs `bash -n` and `shellcheck -x` against `templates/template-base.sh` on every
  push and pull request, so the skeleton cannot ship broken.
- The template traps `INT TERM` to `trap_exit`, contains no `eval`, and does not blanket
  `set -e`: failure checks are expected to be explicit per house style.
