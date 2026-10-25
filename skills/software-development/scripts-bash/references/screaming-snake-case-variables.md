# SCREAMING_SNAKE_CASE Variables

**Owner:** Vituvo
**Purpose:** Live reference of every global variable used across Vituvo bash scripts, with a one-line definition of each.
**Scope:** SCREAMING_SNAKE_CASE globals only. Function locals (lowercase) are per-script and not tracked here.

---

## Rules

- **Globals** = `SCREAMING_SNAKE_CASE` (this file)
- **Function locals** = lowercase (never listed here)
- **Environment variables** = `SCREAMING_SNAKE_CASE` (Docker `-e SOME_FLAG=0`, etc.)
- **CLI subcommand names** = lowercase (case patterns like `install|start|stop`)
- **Natural-language strings in echoes** = normal English (never uppercase for readability)

## When adding a variable

1. Confirm it isn't already listed under any section below.
2. Pick the correct `##` section, or create a new one if none fits.
3. Add the row alphabetically within its section.
4. Write a one-line definition that says what the variable IS, its type/format if relevant, and what sets it if not obvious.
5. Names are effectively permanent — pick carefully. Definitions can be edited when meaning genuinely shifts.

---

## Script metadata

| Variable | Definition |
|---|---|
| `ARG_ERROR` | Last CLI or validation error message for usage screens and pickers. Cleared or overwritten per failed parse. |
| `DEBUG` | Boolean-as-string (`"true"` / `"false"`). Gates the start banner and any conditional verbose output. Quoted always - never `1`/`0`. |
| `HEADER_HOLD_SEC` | Seconds to pause after the start banner before the next `clear` (default `3`). |
| `HOST_NAME` | Machine hostname — `$(hostname)` — used to build API URLs (e.g. ``<host>.local``). |
| `MACHINE_ARCH` | Machine architecture — `$(uname -m)` — used for arch-specific install branches (e.g. `aarch64` vs `x86_64`). |
| `ROUTINE` | The first CLI arg (`$1`), defaulted to `"usage"`. Drives the main `case` block. |
| `RUN_USER` | The user the script is running as — `$(id -un)` — used for `usermod`, `chown`, and other user-scoped ops. Portable across machines. |
| `SCRIPT_START` | Unix epoch seconds captured at script start — `$(date +%s)`. Used by `sexit` to compute runtime. Named to avoid collision with the `start` routine in the `case` block. |
| `START_WAIT_TIME` | Seconds to wait after starting a service before health-checking (default `12`). Passed to `wait_spinner`. |
| `TITLE` | Human-readable script title displayed in the start banner and completion footer. |
| `USAGE_PAD_COL` | Column number where usage description text aligns in `#==` padded usage lines (default `68`). |
| `VERSION` | Semver or date string shown in the start banner (e.g. `4.1.0`). |
| `VLABEL_WIDTH` | printf width for verbose status label column in `vline` (default `10`). |
| `UPDATE_AVAILABLE` | Boolean-as-string set by `check_for_update()`. `"true"` if `git fetch` shows new commits upstream. |
| `W_DIR` | The working directory the script was invoked from — `$(realpath .)`. Restored via `cd "$W_DIR"` after arg validation. |
| `WAS_RUNNING` | Boolean-as-string set at the top of the `update` routine to remember whether the container was running before the update, so it can be restarted after. |

## Script state (PIDs)

| Variable | Definition |
|---|---|
| `ACTIVE_DL_PID` | PID of a background download (weights, artifacts, archives). Killed by `trap_exit` on Ctrl+C. Used when downloads must run alongside other bg ops. |
| `ACTIVE_DOCKER_PID` | PID of a background `docker` or `docker compose` operation. Killed by `trap_exit`. |
| `ACTIVE_PULL_PID` | PID of a background `docker pull` process. Killed by `trap_exit`. Used when a pull runs alongside other bg ops. |
| `ACTIVE_SPINNER_PID` | PID of a background spinner in multi-op scripts that need concurrent named PIDs. Killed by `trap_exit`. |
| `CHILD_PID` | PID of an active background child (e.g. Python fetch). Killed by `trap_exit` on Ctrl+C. |
| `SPINNER_PID` | PID of the single active background spinner started by `start_spinner`. Cleared by `stop_spinner`. Killed by `trap_exit`. Use this in simple single-op scripts. |
| `STOPPED` | Integer guard (`0` or `1`) set by `trap_exit` to prevent re-entrant interrupt handling. |

## Docker / paths

Anything an install / start / stop / status script touches on disk.

Docker / paths
| Variable | Definition |
|---|---|
| `BIN_DIR` | Directory holding built binaries (e.g. `~/.<engine>/build/bin`). |
| `CONTAINER_NAME` | The `--name` value for the main Docker container the script manages. |
| `DOCKER_IMAGE` | Full image reference (`repo/name:tag`) that the script pulls / runs. |
| `IMAGE_NAME` | Local image name / tag used when building images from source (e.g. via `make build`). |
| `INSTALL_DIR` | Root of the install (e.g. `~/.<engine>`). Everything under it belongs to this script. |
| `REPO_URL` | Upstream git repo URL — `git clone`d during install. |
| `SYSTEMD_OVERRIDE` | Absolute path to a systemd drop-in file the script writes (e.g. `/etc/systemd/system/<unit>.service.d/user-models.conf`). |
| `VERSION_FILE` | Path to a hidden state file that records the installer's last known version — used to gate upgrade logic. |
| `ZZZ_DATE_FILE` | Path to a hidden date-stamp file used for monthly log-flush gating in cron-run scripts. |
## ANSI colors (tput)

Set via `tput setaf` with a raw-`""` fallback. Reset (`RT`) always follows any colored token.

| Variable | Definition |
|---|---|
| `B` | Bold — command names in usage, key values in summaries. |
| `BC` | Cyan — descriptive message text / content / data. |
| `BG` | Green — label keys (`Starting`, `Completd`, `Found`, `Status`, `Ready`). |
| `BR` | Red — structural characters (`#==` borders, `[` `]` brackets, error labels). |
| `BY` | Yellow — timestamps, titles, values, the trailing `...` ellipsis. |
| `RR` | Bright red — error / stopped / failed states. |
| `RT` | Reset — used after EVERY colored token to prevent bleed. |

