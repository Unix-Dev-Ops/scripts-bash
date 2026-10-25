---
name: scripts-bash
description: "Use when creating, writing, rewriting, revising, restyling, or reviewing any bash (.sh) installer/manager/automation script—especially short user prompts like 'rewrite this script: /path/foo.sh'. Auto-applies rigid ops-script standard: fixed header, SCREAMING_SNAKE_CASE, ANSI logs, spinners, ROUTINE/case, sexit, craft bar. On rewrite: write version-bumped sibling (name.sh→name-01.sh, name-01.sh→name-02.sh); do not overwrite source unless asked."
version: 4.3.0
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

- **Any** create / write / rewrite / restyle / fix / review of a `.sh` file in coder-bash
- Short prompts: `rewrite this script: /path/to/foo.sh` (load this skill automatically; user need not list steps)
- Installer/manager automation under profile `workspace/`

## Rewrite output naming (automatic)

| Source | Output (same directory) |
|--------|-------------------------|
| `name.sh` | `name-01.sh` |
| `.name.sh` | `.name-01.sh` (leading dot preserved) |
| `name-01.sh` | `name-02.sh` |
| `name-NN.sh` | `name-(NN+1).sh` (2-digit pad) |

Do not overwrite source unless user says overwrite. Keep behavior; apply full style law.
Dotfile / hidden names are normal — not special-case blockers.

## Live skill path

Install / load from:

`~/.hermes/skills/software-development/scripts-bash/`

Do not require a copy under `profiles/*/skills/`. If lookup fails under a profile, use this absolute path.

## Execution discipline (rewrites)

1. Load this skill + read source in early tool calls.
2. **Call `write_file` in the same turn you decide to write** — no "Writing now." / "Resuming…" without a tool call.
3. No multi-paragraph status recaps between tools.
4. After write: `bash -n`; chat reports path + size only.
5. If a prior turn stalled before write: **retry write immediately**.

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
| Publish | Edit live skill under `~/.hermes/skills/software-development/scripts-bash/`; copy into git package only when releasing. |

## Pitfalls

- Duplicate skeleton files inside the skill (forbidden — one template only)
- Shipping fat production installers inside the skill
- Divergent skill copies (global / profile / github out of sync)
- `START` as timer name (collides with `start` routine)
- `show_usage` calling `sexit`
- Blind `set -e` on scripts full of intentional non-zero tests
- Forgetting `stop_spinner` on failure paths
- Skill name confusion: skill is **`scripts-bash`**, profile may be named `coder-bash`

## Clone an existing installer

Adapting a **working** script for a sibling product or a new version pin — not a rewrite.

1. Read the working product; it is the template, not `template-base.sh`.
2. Copy it whole to the named path and change only the values that differ. Everything else
   — routines, helpers, naming, style — carries over unchanged.
3. The named path is the brief. "Copy this to folder X" is a new product; "copy it inside the
   folder and name it `foo.sh`" is a sibling with that exact filename. Neither is a `name-01.sh`.
4. Do not silently inherit a sibling's side effects (auto-stopping other services, killing
   containers, touching shared state) just because the source had them.
5. Write the file as soon as the value diff is known. Research that turns into narration is a
   stalled turn, not progress.

## Bash gotchas

Learned the hard way; none of them are specific to any machine.

- `find -L <root> -xtype l` flags every **valid** symlink as broken on GNU find. Scan with `-P`
  and use `-L` only when you must descend directory symlinks.
- Python `os.walk` puts a **dangling** symlink in `files`, not `dirnames` — scanning `dirnames`
  misses broken links silently. Use `os.scandir`, check `is_symlink()` before `is_dir()`.
- `local a="$1" b="${a}/x"` reads empty for `b`: bash declares every name in the list before
  assigning. Put a reference to an earlier name on its own `local` line.
- `bash -n` never flags an undefined variable. After adding a global, grep the variable block for
  its `VAR=` in the same edit — a URL built from an unset variable no-ops every call that uses it.
- An interrupted patch can leave both the old and the new copy of a function; bash quietly runs
  the **last** one. Re-check `grep -n '^name(){'` before trusting an edit that spanned a stall.
- `[[ test ]] && command` at the top level under `set -e` aborts the script when the test is
  false. Use `if`/`fi` — this failure looks like a mysterious early exit, not a syntax error.
- `git ls-remote --quiet HEAD "${REPO_URL}"` is reversed: URL first, ref second. Backwards, `HEAD`
  is taken as the repo path and the probe fails instantly while `git pull` works fine.
- Strip ANSI and carriage returns before grepping ssh output:
  `sed -e "s/\x1b\[[0-9;]*[mK]//g" -e "s/\r/\n/g"`. Spinner bytes otherwise garble the capture.
- Prove a guard actually refuses with `bash script dryrun >/dev/null 2>&1; echo $?` —
  `bash script dryrun | grep ERROR; echo $?` reports grep's status and makes a dead guard verified.
- Self-tests that stand up throwaway remotes need `git init --bare -b main` and `git clone -b main`;
  a bare repo whose HEAD sits on unborn `master` makes `push -u` fail quietly, and the test then
  blames the product for its own setup.
- Editing another script by line ranges: apply edits bottom-up or recompute indices. A slice that
  changes the line count shifts every later index and can eat an unrelated function's header.
- Never parse a directory listing to pick a path — glob into an array and test `-d` (SC2012).
- A scheduled routine must not print banners or spinners: force `DEBUG="false"` before argument
  handling and log to a file. Cron output that reaches a mailbox is output nobody reads.
- A warning-only failure should `exit 0`. A non-zero exit lands in the failure queue where
  notifications get suppressed, so the report nobody sees is the report nobody sees.
- A fix found while debugging is not done until it is in the lifecycle — install creates it,
  update re-applies it, purge removes it, dryrun says so. Anything belonging upstream is an issue
  on that repo, not an edit your script quietly re-rolls each run.
- Answer the literal question in the first line, then at most one confirming call. Long
  verification loops are not diligence when the operator is short on tokens.

## Version

- **4.3.0** — 2026-10-24: stripped to portable teaching content. Hostnames become `<host>.local`
  placeholders, stack-specific variables moved out, housekeeping docs pruned.
- **4.2.4** — Global path only; no-preamble write discipline; dotfile version bump
- **4.2.3** — Single live install; no profile skill copy; git = publish only
- **4.2.2** — Auto rewrite triggers; version-bump output paths (name.sh→name-01.sh…)
- **4.2.1** — Single template at `templates/template-base.sh`; removed duplicate references/examples copies
- **4.2.0** — Craft bar; SOUL/AGENTS alignment
- **4.1.x** — Authoring tutorial; lean hub package
- **4.0.0** — Initial hub-oriented layout
  one box's installer rules (hosts, containers, model engines, ports, benchmarks) had accumulated in
  the live file without ever being committed or reviewed; they are no longer part of the skill, and
  the generic lessons they were buried under are kept above as `Bash gotchas` and `Clone an existing
  installer`. Nothing here assumes a machine, a model server, or a client.
