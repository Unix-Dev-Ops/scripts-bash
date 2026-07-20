# Publish checklist (scripts-bash)

## Ship this tree only

```text
skills/software-development/scripts-bash/
  SKILL.md
  README.md
  PUBLISH.md
  templates/template-base.sh
  references/screaming-snake-case-variables.md
  references/authoring.md
```

## This machine — three installs (keep identical)

| Role | Path |
|------|------|
| Global | `~/.hermes/skills/software-development/scripts-bash/` |
| coder-bash profile | `~/.hermes/profiles/coder-bash/skills/scripts-bash/` |
| Git push | `~/.hermes/projects/scripts-bash/` |

Do **not** remove the global skill. After edits: `cp -a` across all three.

## Checks

```bash
bash -n templates/template-base.sh
```
