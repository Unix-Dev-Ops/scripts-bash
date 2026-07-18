# scripts-bash

**Hermes Agent skill** for long-lived bash installer/manager scripts.

Rigid house standard: fixed header, SCREAMING_SNAKE_CASE globals, ANSI logs, spinner suite, `ROUTINE` + `case` CLI, hard verification gates.

| | |
|--|--|
| **Author / maintainer** | [Vituvo](https://github.com/Unix-Dev-Ops) (`Unix-Dev-Ops`) |
| **Skill path** | `skills/software-development/scripts-bash/` |
| **License** | MIT |
| **Version** | See skill `SKILL.md` frontmatter |

## Install (Hermes)

```bash
# Clone
git clone https://github.com/Unix-Dev-Ops/scripts-bash.git
cd scripts-bash

# Copy into Hermes skills
mkdir -p ~/.hermes/skills/software-development
cp -a skills/software-development/scripts-bash \
  ~/.hermes/skills/software-development/

# Optional: mirror into a profile
# cp -a skills/software-development/scripts-bash \
#   ~/.hermes/profiles/<profile>/skills/
```

Reload skills in session (`/reload-skills` or new chat), then:

```text
/skill scripts-bash
```

Or open `references/authoring.md` for the 5-step recipe.

## What’s in the package

```text
skills/software-development/scripts-bash/
  SKILL.md
  README.md
  PUBLISH.md
  references/template-base.sh
  references/screaming-snake-case-variables.md
  references/authoring.md
  templates/template-base.sh
  examples/minimal-service-installer.sh
```

**Not included:** host-specific production installers or private design briefs.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

- Open a PR against `main`
- CODEOWNERS requires maintainer review
- CI runs `bash -n` on shipped shell files

## Security

See [SECURITY.md](SECURITY.md). Do not open issues with secrets.

## License

[MIT](LICENSE) — Copyright (c) 2026 Vituvo
