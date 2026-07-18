---
name: scripts-bash
description: "Use when writing, revising, or reviewing long-lived bash installer/manager scripts. Enforces a rigid ops-script standard: fixed header, SCREAMING_SNAKE_CASE globals, ANSI log lines, spinner suite, case-driven routines, and hard verification gates."
version: 4.2.0
author: Vituvo
license: MIT
platforms: [linux]
metadata:
  hermes:
    tags: [Bash, Scripts, Installers, Automation, CLI, DevOps, Style]
    related_skills: []
---

# scripts-bash

Standard for **long-lived bash installer / manager scripts**. Not for one-liners or tiny hooks.

## When to use

- Create or revise an installer/manager script
- Enforce house style: header, colors, spinners, `ROUTINE` + `case`
- Review a script against this spec

## When NOT to use

- Snippets under ~50 lines, pure libraries, non-bash

## Skill vs products

| | What | Where |
|--|------|--------|
| **Skill** | Rules, template, variable registry, one minimal example | This skill directory |
| **Products** | Scripts you run day to day | Profile workspace (outside the skill) |

Default product layout (relative to the active Hermes profile home):

```text
workspace/
  installers/<tool>/installer-<tool>.sh
  scripts/<purpose>/<name>.sh
```

Do **not** write live products into the skill tree. Copy `templates/template-base.sh` (or `references/template-base.sh`) out to the product path.

## Package contents (lean)

```text
SKILL.md
README.md
PUBLISH.md
references/template-base.sh
references/screaming-snake-case-variables.md
references/authoring.md               # tutorial: how to use this skill
templates/template-base.sh            # same skeleton
examples/minimal-service-installer.sh # ship-safe sample only
```

No production installer trees. No host-specific prompt packs.

## Tutorial

Read **`references/authoring.md`** first time you use the skill. It is the human/agent walkthrough (5-step recipe, good vs bad output, smoke test for reviewers).

## Precedence

1. `references/template-base.sh` (executable truth)
2. This `SKILL.md`
3. `references/screaming-snake-case-variables.md` (append-only globals)
4. `references/authoring.md` (how to apply the law)

## Workflow

1. Load this skill; skim `references/authoring.md` if new
2. Read `references/template-base.sh`
3. Read variable registry before adding globals
4. Copy template → product path under profile `workspace/`
5. Fill header, vars, domain functions; keep skeleton helpers stable
6. Hard gate: `bash -n`, full script, path+size only in chat, version bump

## Hard gates

1. `bash -n` clean
2. No `sudo` / package install / system writes unless user asked
3. No destructive surprise
4. Prefer user-local paths (`~/.hermes/`, `~/.hermes-programs/`, `~/models`) unless user sets otherwise
5. Disk evidence after write
6. Do not rewrite Title Case section comments unless asked
7. SCREAMING_SNAKE jobs rename variables only

## File structure (top → bottom)

```text
1. #!/bin/bash
2. Header (Author / Date / Ver / Name / Define + optional body + Credits)
3. ROUTINE="${1:-usage}"
4. Core vars: W_DIR, TITLE, DEBUG, SPINNER_PID
5. Script-specific globals
6. ANSI tput block + raw "" fallback
7. SCRIPT_START="$(date +%s)"   # never START
8. Functions: trap_exit, display_start_message, sexit, show_banner,
   wait_spinner, start_spinner, stop_spinner, show_usage, check_arguments,
   then domain functions
9. check_arguments "$ROUTINE"
10. case "$ROUTINE" in ... esac
11. sexit
```

## Header

Colons at column 8; trailing `=` pad to column 75. See template.

## Core variables

```bash
ROUTINE="${1:-usage}"
W_DIR="$(realpath .)"
TITLE="Human Readable Title"
DEBUG="true"          # quoted "true"/"false" only
SPINNER_PID=""
SCRIPT_START="$(date +%s)"
```

Globals SCREAMING_SNAKE; function locals lowercase. Document new globals in the registry.

## ANSI roles

| Var | Role |
|-----|------|
| RT | Reset after every colored token |
| BR | Structure |
| BG | Label keys + spinner colon |
| BY | Timestamps, titles, values, `...` |
| BC | Message body |
| B | Bold in usage |
| RR | Errors / stopped / failed |

## Standard functions

Copy from the template. Do not re-invent.

- `trap_exit` — SIGINT/TERM, kill spinner, Stopped, `sexit`, exit 1
- `display_start_message` — banner gated on `DEBUG` only
- `sexit` — Completd + Time; does not exit
- `show_banner` / `show_usage` — usage exits 0 **without** `sexit`
- `wait_spinner` / `start_spinner` / `stop_spinner`
- `check_arguments` — validate, `cd` W_DIR, start message

## Locked style

- ~9-char labels (`Completd` not `Completed`) so colons align
- Echo: colon inside green label; spinner: split color, colon always `BG`
- `sleep 0.05` after routine echoes
- No `dlog` / `pause` wrappers
- Section comments: `# === Title Case 'Quoted' 'Tokens' ===`
- Case: blank line between arms; final `sexit`

## Craft bar (master-script expectations)

House style uses **explicit exit checks** + `sexit; exit 1` (see golden installers). Do **not** slap `set -euo pipefail` on a large installer unless you re-audit every command; optional on small new scripts if you understand `set -e` + pipelines.

| Expectation | Rule |
|-------------|------|
| Quoting | Quote expansions: `"${VAR}"`, `"${array[@]}"`. |
| Tests | Prefer `[[ ... ]]` over `[ ... ]`. |
| Spinner + exit | Capture `cmd_exit=$?` **before** `stop_spinner`; then branch on `cmd_exit`. |
| dryrun | Prefer a `dryrun` routine that prints planned actions and exits 0 with no changes. |
| Idempotent install | Re-run install safely when already installed (skip clone, reuse container, etc.). |
| Dependencies | Check `command -v` for required tools; fail with install hint, no surprise package installs. |
| Privileged ops | No `sudo` unless user explicitly approved this script/run. |
| Secrets | Never embed keys/tokens; read from env or document external setup. |
| shellcheck | Run when available; justify any remaining warnings. |
| Port conflicts | Document and enforce mutual exclusion (e.g. only one listener on a shared port). |
| Dual skill copies | Edit global skill first; `cp -a` to profile mirror. |

## Pitfalls

- Shipping fat production installers inside the skill
- Dual divergent copies of this skill (edit one place, sync the other)
- `START` as timer name (collides with `start` routine)
- `show_usage` calling `sexit`
- Blind `set -e` on scripts full of intentional non-zero tests
- Forgetting `stop_spinner` on failure paths (leaves junk on the TTY)
- Skill name confusion: skill is **`scripts-bash`**, profile may be named `coder-bash`

## Version

- **4.2.0** — Craft bar (quote/[[ ]]/spinner exit/dryrun/idempotency); SOUL/AGENTS alignment; skill name clarity
- **4.1.1** — Added `references/authoring.md` tutorial; host design briefs stay outside skill
- **4.1.0** — Lean hub package: no production installers, no host prompt pack, no v3 archive dump
- **4.0.0** — Initial hub-oriented layout
- **3.x** — Spinner suite / SCRIPT_START / sleep 0.05 (superseded prose)
