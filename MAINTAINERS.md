# Default branch protection expectations

This file documents how the maintainer runs the project. GitHub branch protection is configured on the remote after first push.

## Rules for `main`

1. **No direct push to `main`** for contributors (use PRs).
2. **Require pull request** before merge.
3. **Require review** from CODEOWNERS (`@Unix-Dev-Ops`).
4. **Require status checks** — workflow `validate` must pass.
5. **No force-push** to `main`.
6. **Conversations resolved** before merge (recommended).

## Maintainer merge style

- Prefer **squash merge** for a clean history.
- Delete branch after merge.
- Tag releases when skill version bumps meaningfully: `v4.2.0` matching `SKILL.md`.

## Enabling on GitHub (after repo exists)

Settings → Branches → Add rule for `main`:

- Require a pull request before merging
- Require approvals: 1
- Require review from Code Owners
- Require status checks to pass: `validate`
- Do not allow bypassing the above settings (optional for solo; enable when you add co-maintainers)

Solo maintainer tip: you can temporarily allow admin bypass while learning, then lock it down.
