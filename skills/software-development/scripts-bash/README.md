# scripts-bash

Lean Hermes skill: rigid standard for long-lived bash installer/manager scripts.

## Contents

- `SKILL.md` — agent rules
- `templates/template-base.sh` — **only** executable skeleton
- `references/screaming-snake-case-variables.md` — global name registry
- `references/authoring.md` — how to apply the rules

**Not included:** production installers, host briefs, duplicate templates, examples clone.

## Install

```bash
mkdir -p ~/.hermes/skills/software-development
cp -a scripts-bash ~/.hermes/skills/software-development/
```

Load by name: `scripts-bash`. Do not also copy it into a Hermes profile.

## License

MIT
