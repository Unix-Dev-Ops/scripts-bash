# Authoring guide — scripts-bash

How to use this skill to produce excellent long-lived bash installer/manager scripts.

## Mental model

| Layer | Role |
|-------|------|
| **Skill** | Law: structure, colors, spinners, naming, gates |
| **Template** | Skeleton you copy, never freestyle past |
| **Brief** (optional) | Intent: ports, routines, paths, non-goals |
| **Product** | The `.sh` you run, under profile `workspace/` |

You are not "vibe coding from zero." You are **filling a rigid form** with domain details.

## 5-step recipe

### 1. Load the skill

```text
/skill scripts-bash
```

Or ensure the session can see `software-development/scripts-bash`.

### 2. Read the skeleton and registry

1. `references/template-base.sh` (or `templates/template-base.sh`)
2. `references/screaming-snake-case-variables.md` before inventing globals

### 3. Pick a product path

Under the active profile workspace:

```text
workspace/installers/<tool>/installer-<tool>.sh
# or
workspace/scripts/<purpose>/<name>.sh
```

Never write live products into the skill package.

### 4. State intent (brief)

Give the agent (or write a short `DESIGN.md` next to the product) at least:

- **Purpose** — one sentence
- **Upstream** — repo/image if any
- **Paths** — install root, config, data
- **Ports / conflict** — what binds, what must stop first
- **Routines** — `install|update|status|...`
- **Non-goals** — what this script must not do
- **Elevated ops** — sudo only if you explicitly allow it

Example user message:

```text
Load scripts-bash. Copy the template to
workspace/installers/mytool/installer-mytool.sh
Purpose: manage mytool docker on port 9090.
Routines: install, update, start, stop, status, uninstall.
No sudo. Paths under ~/.hermes-programs/mytool/.
```

### 5. Hard gate before you accept the script

```bash
bash -n path/to/script.sh
# shellcheck if available
```

Agent should:

- Return **full** script, not a fragment
- Confirm **path + size** only (no full dump in chat)
- Bump `Ver` on edits
- Leave Title Case section comments alone unless you asked to change them

## What good output looks like

- Header: Author / Date / Ver / Name / Define, columns aligned
- `ROUTINE` + `check_arguments` + `case` + final `sexit`
- Shared helpers from template (trap, spinners, colors) unchanged in spirit
- New globals added to the registry (append-only)
- Idempotent install/status where claimed
- Failures: clear `RR` error lines, then `sexit; exit 1`
- `cmd_exit=$?` before `stop_spinner`; `dryrun` when useful
- See SKILL.md **Craft bar** for quote / `[[ ]]` / secrets / shellcheck

## What bad output looks like

- New banner system, random emoji logging, unquoted DEBUG
- `START` as timer (collides with `start` routine)
- `show_usage` printing Completd/Time footer
- Secrets in the script body
- Partial "here's the install function only"

## Local design briefs (optional)

On a maintainer machine, product-specific briefs may live next to the workspace products, e.g.:

```text
workspace/prompts/installers/<tool>.md
```

Those are **not** part of the hub skill. They are private memory for regenerating or reviewing your own installers. The skill only needs this authoring recipe + template + registry.

## Friend / review smoke test

1. Install lean `scripts-bash` under `~/.hermes/skills/software-development/`
2. `/reload-skills` or new session
3. Ask: copy template to a throwaway path; add `status` that prints OK
4. Run `bash -n` and `bash that-script.sh status`
5. Confirm header, colors, Completd/Time footer on success path

If that works, the skill is doing its job.
