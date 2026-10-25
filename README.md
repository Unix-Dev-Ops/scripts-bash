# scripts-bash

[![Hermes Skill](https://img.shields.io/badge/Hermes-Skill-7c3aed?style=flat-square)](https://github.com/NousResearch/hermes-agent)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)

**Version 4.3.0** — house style for long-lived bash installer and manager scripts.

![scripts-bash hero - Hermes-grade bash installers](docs/assets/scripts-bash-hero.png)

## What is in this repo

| File | What it is |
|------|------------|
| `skills/software-development/scripts-bash/SKILL.md` | The rules. 277 lines, `version: 4.3.0` in frontmatter. |
| `.../templates/template-base.sh` | The one executable skeleton. 216 lines, 9 functions. |
| `.../references/screaming-snake-case-variables.md` | 39 global variables with definitions. |
| `.../references/authoring.md` | How to apply the rules. |
| `SECURITY.md` | How to report issues, plus bash failure modes this skill treats as security-relevant. |
| `docs/assets/scripts-bash-hero.png` | 1536 × 1024 image above. |

The skill ships **one** template. There is no second copy and no `examples/` directory. CI fails the build if either reappears.

```text
skills/software-development/scripts-bash/
  SKILL.md
  templates/template-base.sh
  references/screaming-snake-case-variables.md
  references/authoring.md
```

This repo is the skill. It does not contain production installers.

## Install

```bash
git clone https://github.com/Unix-Dev-Ops/scripts-bash.git
mkdir -p ~/.hermes/skills/software-development
cp -a scripts-bash/skills/software-development/scripts-bash \
  ~/.hermes/skills/software-development/
```

That lands at `~/.hermes/skills/software-development/scripts-bash/`. Load it by name (`scripts-bash`). Do not also copy it into a Hermes profile — a second copy stops tracking this tree the day either one is edited.

## What the skeleton does

`templates/template-base.sh` defines nine functions. Reuse them; do not rewrite them:

`trap_exit` `display_start_message` `sexit` `show_banner` `wait_spinner`
`start_spinner` `stop_spinner` `show_usage` `check_arguments`

Its usage screen advertises three routines:

```text
install      Install and configure
uninstall    Remove everything
status       Show current status
```

Add more only when the product needs them. `show_usage` exits 0 **without** calling `sexit`; success paths end in `sexit`.

## Verify

CI on `main` and pull requests runs `bash -n` and `shellcheck -x` against `templates/template-base.sh`, and asserts there is no duplicate template and no `examples/` directory.

## Contributing

PRs are reviewed by the maintainer in [CODEOWNERS](.github/CODEOWNERS).

- **Scope** — rules, one template, the registry, and how-to docs. No host-specific production installers, no secrets.
- **One concern per change** — "fix the spinner colon rule", not "rewrite everything".
- **Style is not optional** — match `SKILL.md` and the template.
- **Registry is append-only** — never rename an existing entry without a migration note and maintainer sign-off.

## Security

See [SECURITY.md](SECURITY.md).

## Author

**Vituvo** ([@Unix-Dev-Ops](https://github.com/Unix-Dev-Ops))

## License

[MIT](LICENSE) — Copyright (c) 2026 Vituvo
