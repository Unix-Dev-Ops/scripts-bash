# SCREAMING_SNAKE_CASE Variables

**Owner:** Vituvo
**Purpose:** Live reference of every global variable used across Vituvo bash scripts, with a one-line definition of each.
**Scope:** SCREAMING_SNAKE_CASE globals only. Function locals (lowercase) are per-script and not tracked here.
**Companion file:** `bash-variable-conventions.md` is the historical migration table (lowercase → UPPER). This file is the forward-looking canonical reference.

---

## Rules

- **Globals** = `SCREAMING_SNAKE_CASE` (this file)
- **Function locals** = lowercase (never listed here)
- **Environment variables** = `SCREAMING_SNAKE_CASE` (Docker `-e VLLM_USE_DEEP_GEMM=0`, etc.)
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
| `DEBUG` | Boolean-as-string (`"true"` / `"false"`). Gates the start banner and any conditional verbose output. Quoted always — never `1`/`0`. |
| `HOST_NAME` | Machine hostname — `$(hostname)` — used to build API URLs (e.g. `sparky.local`, `bambino.local`). |
| `MACHINE_ARCH` | Machine architecture — `$(uname -m)` — used for arch-specific install branches (e.g. `aarch64` vs `x86_64`). |
| `ROUTINE` | The first CLI arg (`$1`), defaulted to `"usage"`. Drives the main `case` block. |
| `RUN_USER` | The user the script is running as — `$(id -un)` — used for `usermod`, `chown`, and other user-scoped ops. Portable across machines. |
| `SCRIPT_START` | Unix epoch seconds captured at script start — `$(date +%s)`. Used by `sexit` to compute runtime. Named to avoid collision with the `start` routine in the `case` block. |
| `START_WAIT_TIME` | Seconds to wait after starting a service before health-checking (default `12`). Passed to `wait_spinner`. |
| `TITLE` | Human-readable script title displayed in the start banner and completion footer. |
| `UPDATE_AVAILABLE` | Boolean-as-string set by `check_for_update()`. `"true"` if `git fetch` shows new commits upstream. |
| `W_DIR` | The working directory the script was invoked from — `$(realpath .)`. Restored via `cd "$W_DIR"` after arg validation. |
| `WAS_RUNNING` | Boolean-as-string set at the top of the `update` routine to remember whether the container was running before the update, so it can be restarted after. |

## Script state (PIDs)

| Variable | Definition |
|---|---|
| `ACTIVE_DL_PID` | PID of a background HuggingFace / model-download process. Killed by `trap_exit` on Ctrl+C. Used when downloads must run alongside other bg ops. |
| `ACTIVE_DOCKER_PID` | PID of a background `docker compose` / `docker` operation. Killed by `trap_exit`. Honcho-specific. |
| `ACTIVE_PULL_PID` | PID of a background `docker pull` process. Killed by `trap_exit`. Used when a pull runs alongside other bg ops. |
| `ACTIVE_SPINNER_PID` | PID of a background spinner in multi-op scripts that need concurrent named PIDs. Killed by `trap_exit`. |
| `SPINNER_PID` | PID of the single active background spinner started by `start_spinner`. Cleared by `stop_spinner`. Killed by `trap_exit`. Use this in simple single-op scripts. |

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

## Docker / paths

| Variable | Definition |
|---|---|
| `BIN_DIR` | Directory holding built binaries (e.g. `~/.llamacpp/build/bin`). |
| `CONTAINER_NAME` | The `--name` value for the main Docker container the script manages. |
| `DOCKER_IMAGE` | Full image reference (`repo/name:tag`) that the script pulls / runs. |
| `HERMES_CONFIG` | Path to `~/.hermes/config.yaml`. |
| `IMAGE_NAME` | Local image name / tag used when building images from source (e.g. via `make build`). |
| `INSTALL_DIR` | Root of the install (e.g. `~/.llamacpp`). Everything under it belongs to this script. |
| `MODELS_DIR` | Directory where model weights live (e.g. `~/models`). Shared across vLLM / llama.cpp / SGLang. |
| `REPO_URL` | Upstream git repo URL — `git clone`d during install. |
| `SYSTEMD_OVERRIDE` | Absolute path to a systemd drop-in file the script writes (e.g. `/etc/systemd/system/ollama.service.d/user-models.conf`). |
| `VERSION_FILE` | Path to a hidden state file that records the installer's last known version — used to gate upgrade logic. |
| `ZZZ_DATE_FILE` | Path to a hidden date-stamp file used for monthly log-flush gating in cron-run scripts. |

## Gen server (vLLM)

| Variable | Definition |
|---|---|
| `ENABLE_PREFIX_CACHING` | Boolean-as-string. When `"true"`, passes `--enable-prefix-caching` to vLLM for KV cache reuse across matching prompt prefixes. |
| `GPU_MEM_UTIL` | Float `0.0`-`1.0`. Fraction of GPU memory vLLM is allowed to allocate (`--gpu-memory-utilization`). |
| `MAX_MODEL_LEN` | Max context window in tokens (`--max-model-len`). Bounded by KV cache size. |
| `MAX_NUM_SEQS` | Max concurrent sequences the scheduler will batch (`--max-num-seqs`). Trade-off: throughput vs per-seq latency. |
| `MODELS` | Array of model identifiers the script pulls / manages. Uppercase to avoid collision with a `models` routine name. |
| `MTP_TOKENS` | Multi-token-prediction lookahead count (`--num-speculative-tokens`) when the model supports MTP. |
| `REASONING_PARSER` | vLLM reasoning-parser name (`--reasoning-parser`) — e.g. `deepseek_r1`, `qwen3`. Selects how thinking blocks are parsed out of the stream. |
| `SERVE_HOST` | Bind address for the vLLM API server (`--host`). Usually `0.0.0.0`. |
| `SERVE_HOST_NAME` | Advertised hostname used to build the API URL shown to the user (e.g. `sparky.local`). |
| `SERVE_PORT` | Port the vLLM API server listens on (default `8000`). |
| `SPECULATIVE_CONFIG` | JSON config string passed to `--speculative-config` for speculative decoding (draft model, method, lookahead). |
| `TOOL_CALL_PARSER` | vLLM tool-call-parser name (`--tool-call-parser`) — e.g. `hermes`, `qwen3`. Determines how tool calls are extracted from output. |

## Embed server (vLLM)

| Variable | Definition |
|---|---|
| `EMBED_CONTAINER_NAME` | The `--name` value for the embedding container (kept separate from the gen container). |
| `EMBED_GPU_MEM_UTIL` | Fraction of GPU memory for the embed server. Set low so it coexists with the gen server. |
| `EMBED_HF_OVERRIDES` | JSON string of HuggingFace config overrides passed to vLLM for the embed model (e.g. dtype, task). |
| `EMBED_MODELS` | Array of pipe-delimited embed model specs (`HF_repo|display_name|note`). Populated with one entry per supported embed model. |
| `EMBED_PORT` | Port the embed server listens on (default `8082`). |
| `LOAD_EMBED_SERVER` | Boolean-as-string. When `"true"`, `start` auto-launches the embed server alongside the gen server. |

## Camofox

| Variable | Definition |
|---|---|
| `CAMOFOX_API_KEY` | API key for the Camofox `/sessions/:userId/cookies` import endpoint. Stored in `~/.hermes/.env`. |
| `CAMOFOX_API_URL` | Full HTTP URL for the Camofox API — `http://${CAMOFOX_HOST}:${CAMOFOX_PORT}`. |
| `CAMOFOX_BASE` | Install root for Camofox — `~/.hermes-programs/camofox-browser/`. |
| `CAMOFOX_HOST` | Advertised hostname for Camofox endpoints — `$(hostname)`. Sparky.local / bambino.local depending on machine. |
| `CAMOFOX_NODE_HEAP` | Node.js heap size in MB (`--max-old-space-size`). Passed to the container via env. |
| `CAMOFOX_PERSISTENCE_DIR` | Volume-mounted state dir — `~/.hermes-programs/camofox-browser/.data/`. Holds cookies, profiles, session data. |
| `CAMOFOX_PORT` | Port the Camofox HTTP API listens on (default `9377`). |
| `CAMOFOX_VNC_RESOLUTION` | VNC display resolution — e.g. `1920x1080`. |
| `NOVNC_PORT` | Port the noVNC web viewer listens on (default `6080`). Browser access via `http://host:6080/vnc.html`. |
| `VNC_PORT` | Native VNC port (default `5901`). For desktop VNC clients. |

## Hermes agent

| Variable | Definition |
|---|---|
| `CONFIG_FILES` | Array of config file paths that get locked (immutable) during hardening. Includes `.env`. |
| `CONFIG_YAML_FILES` | Array of unlockable config file paths — YAML configs the user may need to edit. `.env` never included. |
| `HERMES_BIN` | Path to the Hermes launcher — `~/.local/bin/hermes`. |
| `HERMES_DIR` | Hermes install root — `~/.hermes/`. |
| `HERMES_ENV` | Path to the Hermes environment file — `~/.hermes/.env`. Holds API keys and endpoint URLs. |
| `HERMES_REPO` | Path to the cloned `hermes-agent` git repo — `~/.hermes/hermes-agent/`. |
| `LLAMA_MODEL` | Name of the llama.cpp model used when configuring the llama.cpp endpoint in Hermes config. |
| `LLAMA_PORT` | Port the llama.cpp server listens on (default `8080`). |
| `LLAMA_URL` | Full URL to the llama.cpp OpenAI-compatible endpoint — `http://${HOST_NAME}:${LLAMA_PORT}/v1`. |
| `OLLAMA_PORT` | Port the Ollama daemon listens on (default `11434`). |
| `OLLAMA_URL` | Full URL to the Ollama endpoint — `http://${HOST_NAME}:${OLLAMA_PORT}`. |
| `UV_BIN` | Path to the `uv` Python package manager binary — `~/.local/bin/uv`. |
| `VLLM_PORT` | Port the vLLM server listens on (default `8000`). |
| `VLLM_URL` | Full URL to the vLLM OpenAI-compatible endpoint — `http://${HOST_NAME}:${VLLM_PORT}/v1`. |

## Llama.cpp

| Variable | Definition |
|---|---|
| `LOAD_MODEL` | Filename (not path) of the GGUF model llama-server should load on start. Resolved against `MODELS_DIR`. |
| `REASONING_BUDGET` | Token budget for reasoning/thinking output. `0` = thinking off; positive = max thinking tokens. Displayed in the start banner. |

## Ollama

| Variable | Definition |
|---|---|
| `KEEP_ONLY_MODELS` | Array of installed model names that must never be pruned (e.g. local `daystar:v1`). Complements the `daystar*` wildcard protection. |
| `LATEST_OLLAMA_VERSION` | Latest release tag pulled from `api.github.com/repos/ollama/ollama/releases/latest`. Compared against installed binary to gate upgrades. |
| `OLLAMA_MODELS_DIR` | User-scoped model storage — `~/.ollama/models/`. Overrides the system default via systemd drop-in. |
| `OLLAMA_STATE_DIR` | Parent of `OLLAMA_MODELS_DIR` — `~/.ollama/`. Holds models plus the installer version file. |
| `PULLS_FAILED` | Array populated by `sync_models` with any model names whose `ollama pull` returned non-zero. Reported in the summary. |
| `PULLS_OK` | Array populated by `sync_models` with model names that pulled successfully. |
| `PULLS_SKIPPED` | Array populated by `sync_models` with model names that were skipped because they were already installed. |
| `REMOVED_COUNT` | Integer set by `prune_models` — number of installed models that were removed because they weren't in `MODELS` or `KEEP_ONLY_MODELS`. |