# Authoring guide — scripts-bash

How to use this skill to produce excellent long-lived bash installer/manager scripts.

## Mental model

| Layer | Role |
|-------|------|
| **Skill** | Law: structure, colors, spinners, naming, gates |
| **Template** | `templates/template-base.sh` — only skeleton; copy it, never freestyle past it |
| **Brief** (optional) | Intent: ports, routines, paths, non-goals |
| **Product** | The `.sh` you run, under profile `workspace/` |

You are not "vibe coding from zero." You are **filling a rigid form** with domain details.


## Short rewrite (automatic)

User says only: `Rewrite this script: /path/to/foo.sh`

Agent must:

1. Load scripts-bash from `~/.hermes/skills/software-development/scripts-bash/`
2. Read source
3. Write version-bumped sibling in the **same directory** (`.foo.sh` → `.foo-01.sh`)
4. **Issue write_file without preamble** (no "Writing now" status essays)
5. `bash -n`; report path + size only

User does not list skill files or steps.

## 5-step recipe

### 1. Load the skill

```text
/skill scripts-bash
```

### 2. Read the skeleton and registry

1. `templates/template-base.sh` (single executable truth)
2. `references/screaming-snake-case-variables.md` before inventing globals

### 3. Pick a product path

```text
workspace/installers/<tool>/installer-<tool>.sh
# or
workspace/scripts/<purpose>/<name>.sh
```

Never write live products into the skill package.

### 4. State intent (brief)

- Purpose, upstream, paths, ports/conflicts, routines, non-goals, sudo yes/no

Example:

```text
Load scripts-bash. Copy templates/template-base.sh to
workspace/installers/mytool/installer-mytool.sh
Purpose: manage mytool docker on port 9090.
Routines: install, update, start, stop, status, uninstall.
No sudo. Paths under ~/.hermes-programs/mytool/.
```

### 5. Hard gate

```bash
bash -n path/to/script.sh
# shellcheck if available
```

Agent: full script only; path+size in chat; bump Ver; leave Title Case comments alone unless asked.

## What good output looks like

- Header Author/Date/Ver/Name/Define, columns aligned
- `ROUTINE` + `check_arguments` + `case` + final `sexit`
- Helpers from template unchanged in spirit
- New globals appended to registry
- `cmd_exit=$?` before `stop_spinner`; `dryrun` when useful
- See SKILL.md **Craft bar**

## What bad output looks like

- New banner system, emoji logging, unquoted DEBUG
- `START` as timer; `show_usage` with Completd footer
- Secrets in script body
- Partial "here's only the install function"
- Second copy of the template inside the skill

## Local design briefs (optional)

Host-only product briefs may live under profile `workspace/prompts/` — not in this skill package.

## Friend / review smoke test

1. Install lean skill under `~/.hermes/skills/software-development/scripts-bash/`
2. `/skill scripts-bash`
3. Copy `templates/template-base.sh` to a throwaway path; add `status` that prints OK
4. `bash -n` and run `status`
