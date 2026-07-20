# Contributing to scripts-bash

Thanks for helping. This repo ships a **Hermes skill**, not a random bash dump. Changes must keep the skill lean and the standard consistent.

## Maintainer

| Role | GitHub |
|------|--------|
| Author / primary maintainer | [@Unix-Dev-Ops](https://github.com/Unix-Dev-Ops) (Vituvo) |

All PRs require review from CODEOWNERS before merge.

## Ground rules

1. **Scope** — Skill law, template, registry, authoring docs, minimal example only. No host-specific production installers, no secrets, no personal machine paths as requirements.
2. **One concern per PR** — e.g. “fix spinner colon rule” not “rewrite everything.”
3. **Style is not optional** — Match `SKILL.md` and `references/template-base.sh`. Do not invent a second banner system.
4. **Globals** — Append to `screaming-snake-case-variables.md` only; never rename existing registry entries without a migration note and maintainer OK.
5. **Comments** — Do not rewrite Title Case section comments unless the PR is explicitly about comments.
6. **Verify before push:**

```bash
bash -n skills/software-development/scripts-bash/templates/template-base.sh
bash -n skills/software-development/scripts-bash/templates/template-base.sh
# shellcheck if available
```

## Workflow (professional default)

```bash
git clone https://github.com/Unix-Dev-Ops/scripts-bash.git
cd scripts-bash
git checkout -b feat/short-description

# edit…
git add -A
git status
git commit -m "feat: short description"
git push -u origin HEAD
```

Open a Pull Request on GitHub against `main`.

Use [Conventional Commits](https://www.conventionalcommits.org/) when you can:

- `feat:` new capability
- `fix:` bug fix
- `docs:` documentation only
- `refactor:` no behavior change
- `chore:` tooling / CI

## Pull request checklist

- [ ] Describes *why*, not only *what*
- [ ] `bash -n` clean on touched `.sh` files
- [ ] No secrets, tokens, or private host-only paths
- [ ] Skill version bumped in `SKILL.md` if behavior/docs of the skill changed
- [ ] `authoring.md` / README updated if the user workflow changed

## Review (what maintainers look for)

- Correctness and edge cases
- Consistency with template + craft bar in `SKILL.md`
- Security (no credential leakage)
- Lean package size (no fat exemplars)
- Clear commit/PR message

## Issues

- Bugs: use the bug template
- Features: use the feature template
- Security: see SECURITY.md (do not file public issues with exploit details if sensitive)

## Code of conduct

Be respectful. No harassment. Maintainer may close abusive or off-topic threads.
