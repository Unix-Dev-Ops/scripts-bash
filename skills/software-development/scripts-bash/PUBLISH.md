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

## Local (this machine)

- Git / push: `~/.hermes/projects/scripts-bash`
- Live Hermes (coder-bash): `~/.hermes/profiles/coder-bash/skills/scripts-bash/`
- After edit: keep those two trees identical (`cp -a`)

No third global copy under `~/.hermes/skills/`.

## Checks

```bash
bash -n templates/template-base.sh
```
