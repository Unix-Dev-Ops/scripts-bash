---
name: scripts-bash
description: "Use when writing, revising, or reviewing long-lived bash installer/manager scripts. Enforces a rigid ops-script standard: fixed header, SCREAMING_SNAKE_CASE globals, ANSI log lines, spinner suite, case-driven routines, and hard verification gates."
version: 4.2.1
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
| **Skill** | Rules, single template, variable registry, authoring | This skill directory |
| **Products** | Scripts you run day to day | Profile workspace (outside the skill) |

Default product layout (relative to the active Hermes profile home):

```text
workspace/
  installers/<tool>/installer-<tool>.sh
  scripts/<purpose>/<name>.sh
```

Do **not** write live products into the skill tree. Copy **`templates/template-base.sh`** out to the product path.

## Package contents (lean)

```text
SKILL.md
README.md
PUBLISH.md
templates/template-base.sh                      # ONLY executable skeleton
references/screaming-snake-case-variables.md
references/authoring.md
```

One skeleton only. No duplicate templates. No `examples/` clone of the same file. No symlinks.

## Tutorial

Read **`references/authoring.md`** first time you use the skill.

## Precedence

1. `templates/template-base.sh` (executable truth — single file)
2. This `SKILL.md`
3. `references/screaming-snake-case-variables.md` (append-only globals)
4. `references/authoring.md` (how to apply the law)

## Workflow

1. Load this skill; skim `references/authoring.md` if new
2. Read `templates/template-base.sh`
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

Copy from `templates/template-base.sh`. Do not re-invent.

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

House style uses **explicit exit checks** + `sexit; exit 1`. Do **not** slap `set -euo pipefail` on a large installer unless you re-audit every command; optional on small new scripts if you understand `set -e` + pipelines.

| Expectation | Rule |
|-------------|------|
| Quoting | Quote expansions: `"${VAR}"`, `"${array[@]}"`. |
| Tests | Prefer `[[ ... ]]` over `[ ... ]`. |
| Spinner + exit | Capture `cmd_exit=$?` **before** `stop_spinner`; then branch on `cmd_exit`. |
| dryrun | Prefer a `dryrun` routine that prints planned actions and exits 0 with no changes. |
| Idempotent install | Re-run install safely when already installed. |
| Dependencies | Check `command -v`; fail with install hint, no surprise package installs. |
| Privileged ops | No `sudo` unless user explicitly approved. |
| Secrets | Never embed keys/tokens. |
| shellcheck | Run when available; justify remaining warnings. |
| Port conflicts | Document and enforce mutual exclusion. |
| Dual skill installs | Edit global skill first; `cp -a` to profile mirror and git repo skill tree. |

## Pitfalls

- Duplicate skeleton files inside the skill (forbidden — one template only)
- Shipping fat production installers inside the skill
- Divergent skill copies (global / profile / github out of sync)
- `START` as timer name (collides with `start` routine)
- `show_usage` calling `sexit`
- Blind `set -e` on scripts full of intentional non-zero tests
- Forgetting `stop_spinner` on failure paths
- Skill name confusion: skill is **`scripts-bash`**, profile may be named `coder-bash`

## Version

- **4.2.1** — Single template at `templates/template-base.sh`; removed duplicate references/examples copies
- **4.2.0** — Craft bar; SOUL/AGENTS alignment
- **4.1.x** — Authoring tutorial; lean hub package
- **4.0.0** — Initial hub-oriented layout
