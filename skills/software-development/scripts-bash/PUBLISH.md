# Publish checklist (scripts-bash)

## Live install (Hermes)

`~/.hermes/skills/software-development/scripts-bash/`

## Git repo (ship)

`~/.hermes/projects/scripts-bash/`

```text
skills/software-development/scripts-bash/
  SKILL.md
  README.md
  PUBLISH.md
  templates/template-base.sh
  references/screaming-snake-case-variables.md
  references/authoring.md
```

## Release flow

1. Edit/test live skill under `~/.hermes/skills/software-development/scripts-bash/`
2. Copy into git package path above
3. Commit + push from `~/.hermes/projects/scripts-bash`

No profile skill copy. No triple live installs.

## Checks

```bash
bash -n templates/template-base.sh
```
