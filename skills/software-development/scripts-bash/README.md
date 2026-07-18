# scripts-bash

Lean Hermes skill: rigid standard for long-lived bash installer/manager scripts.

## Contents

- `SKILL.md` — agent rules
- `references/template-base.sh` — executable skeleton
- `references/screaming-snake-case-variables.md` — global name registry
- `references/authoring.md` — tutorial (how to create excellent scripts with this skill)
- `templates/template-base.sh` — same skeleton
- `examples/minimal-service-installer.sh` — ship-safe sample only
- `PUBLISH.md` — hub notes

**Not included:** production installers, host-specific design briefs, large archives.

## Install

```bash
mkdir -p ~/.hermes/skills/software-development
cp -a scripts-bash ~/.hermes/skills/software-development/
# optional profile mirror:
cp -a scripts-bash ~/.hermes/profiles/<profile>/skills/
```

Reload skills in session.

## Products vs skill

Scripts you run belong in the profile **workspace** (`installers/`, `scripts/`), not inside this package.

## License

MIT
