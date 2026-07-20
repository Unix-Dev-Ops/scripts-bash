# scripts-bash

Lean Hermes skill: rigid standard for long-lived bash installer/manager scripts.

## Contents

- `SKILL.md` — agent rules
- `templates/template-base.sh` — **only** executable skeleton
- `references/screaming-snake-case-variables.md` — global name registry
- `references/authoring.md` — how to create excellent scripts
- `PUBLISH.md` — hub notes

**Not included:** production installers, host briefs, duplicate templates, examples clone.

## Install

```bash
mkdir -p ~/.hermes/skills/software-development
cp -a scripts-bash ~/.hermes/skills/software-development/
# optional profile mirror:
cp -a scripts-bash ~/.hermes/profiles/<profile>/skills/
```

Reload skills in session. Load: `/skill scripts-bash`

## Products vs skill

Scripts you run belong in the profile **workspace** (`installers/`, `scripts/`), not inside this package.

## License

MIT
