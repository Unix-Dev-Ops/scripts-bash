# scripts-bash

**A [Hermes Agent](https://github.com/NousResearch/hermes-agent) skill** for writing excellent long-lived bash installer and manager scripts.

Drop it into Hermes. Load the skill. Copy the template. Ship installers that look and behave like a real ops toolkit - not vibecoded one-offs.

| | |
|--|--|
| **For** | [Hermes Agent](https://hermes-agent.nousresearch.com/) by Nous Research |
| **Category** | `software-development` (bash / installers / automation) |
| **Author** | [Vituvo](https://github.com/Unix-Dev-Ops) (`Unix-Dev-Ops`) |
| **License** | MIT |
| **Install path** | `~/.hermes/skills/software-development/scripts-bash/` |

> This repository is **only** the Hermes skill package. It is not a Kaggle project, not a Google ADK app, and not a dump of private host installers.

## Why Hermes

Hermes already runs your terminal, files, profiles, and cron. What it often lacks out of the box is a **strict house style** for the bash that manages real services (Docker, local inference, agent stack tools).

`scripts-bash` gives Hermes:

- A locked **header + color + spinner + ROUTINE/case** standard
- An executable **template** agents copy instead of freestyling
- A **SCREAMING_SNAKE** global registry so names stay stable
- An **authoring recipe** so humans and agents create the same quality
- Hard gates: `bash -n`, full scripts, no secret dumps, products outside the skill tree

Use it so Hermes output matches production ops scripts - cinematic logs, clean Ctrl+C, idempotent install paths - the kind of bash you keep for years.

## Install (drop-in)

```bash
git clone https://github.com/Unix-Dev-Ops/scripts-bash.git
mkdir -p ~/.hermes/skills/software-development
cp -a scripts-bash/skills/software-development/scripts-bash \
  ~/.hermes/skills/software-development/
```

In a Hermes session:

```text
/reload-skills
/skill scripts-bash
```

Optional: mirror into a profile:

```bash
cp -a ~/.hermes/skills/software-development/scripts-bash \
  ~/.hermes/profiles/<profile>/skills/
```

## Quick use

```text
Load scripts-bash. Copy the template to
workspace/installers/mytool/installer-mytool.sh
Purpose: manage mytool. Routines: install, status, uninstall.
No sudo.
```

Read **`skills/software-development/scripts-bash/references/authoring.md`** for the full 5-step recipe.

## Package layout

```text
skills/software-development/scripts-bash/
  SKILL.md                                 # Hermes skill entry (frontmatter)
  references/template-base.sh              # executable skeleton
  references/screaming-snake-case-variables.md
  references/authoring.md                  # how to create excellent scripts
  templates/template-base.sh
  examples/minimal-service-installer.sh    # ship-safe sample only
  README.md / PUBLISH.md
```

**Not in this repo:** private production installers, host design briefs, API keys.

## Contributing / maintainers

- [CONTRIBUTING.md](CONTRIBUTING.md) - PRs, conventional commits, review bar
- [MAINTAINERS.md](MAINTAINERS.md) - branch protection expectations
- [SECURITY.md](SECURITY.md) - private vulnerability reports
- CODEOWNERS requires review from **@Unix-Dev-Ops**

## Related

- Hermes Agent: https://github.com/NousResearch/hermes-agent  
- Hermes docs: https://hermes-agent.nousresearch.com/docs  

## License

[MIT](LICENSE) - Copyright (c) 2026 Vituvo
