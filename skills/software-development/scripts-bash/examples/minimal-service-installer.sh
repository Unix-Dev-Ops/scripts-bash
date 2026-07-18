#!/bin/bash
#
# Author: Vituvo ==========================================================
# Date  : <Month DD, YYYY> ================================================
# Ver   : 1.3 =============================================================
# Name  : <script-name.sh> ================================================
# Define: <One-line purpose statement> ====================================
# =========================================================================
#
# <Optional multi-line description of what this script manages.>
# <Note any port bindings, mutual exclusion, or side-effects.>
#
# Credits:
#   *  <optional attribution lines>
# =========================================================================

# === Routine 'Argument' ===
ROUTINE="${1:-usage}"

# === Script 'Variables' ===
W_DIR="$(realpath .)"
TITLE="<Human Readable Title>"
DEBUG="true"
SPINNER_PID=""                                          # Tracks 'active' background spinner - killed on 'Ctrl+C' or stop_spinner

# === ANSI 'Color' Codes for Console Output ===
# tput with raw fallback - works on any terminal, degrades gracefully on
# systems without terminfo.
#
if tput setaf 1 &>/dev/null; then
  RT="$(tput sgr0)"       # Reset
  BR="$(tput setaf 1)"    # Red
  BG="$(tput setaf 2)"    # Green
  BY="$(tput setaf 3)"    # Yellow
  BC="$(tput setaf 6)"    # Cyan
  B="$(tput bold)"        # Bold
  RR="$(tput setaf 9)"    # Bright Red
else
  RT=""; BR=""; BG=""; BY=""; BC=""; B=""; RR=""
fi

# === Track 'Script' Execution Start Time ===
# Named SCRIPT_START (not START) to avoid collision with the 'start' routine
# in the main case block. Used by sexit to compute runtime.
#
SCRIPT_START="$(date +%s)"

# === 'Functions' ===
# === =========== ===

# === Ctrl+C 'Handler' - Trap 'SIGINT' Cleanly ===
# Kills any active spinner, prints Stopped + optional NOTE,
# calls sexit for the standard footer, then exits 1.
#
trap_exit(){
  printf "\r\033[K"

  # === Kill 'Active' 'Spinner' Process if Running ===
  if [[ -n "${SPINNER_PID}" ]]; then
    kill "${SPINNER_PID}" 2>/dev/null
    wait "${SPINNER_PID}" 2>/dev/null
    SPINNER_PID=""
  fi

  echo -e "${BR}[${RT}${BY}$(date +"%m-%d-%Y %H:%M:%S")${BR}]${RT} - ${RR}Stopped  :${RT} ${BC}Script interrupted by user - exiting cleanly${RT} ${BY}...${RT}"
  sexit
  exit 1
}
trap trap_exit INT TERM

# === Display 'Script' Start 'Message' ===
# Clears screen, prints the header separator + title (with argument in brackets),
# then the "Starting :" line. Entire body gated on DEBUG so DEBUG=false is silent.
#
display_start_message(){
  if [[ "$DEBUG" = "true" ]]; then
    clear
    echo -e "\n${BR}#== ============================================================${RT}"; sleep 0.05
    echo -e "${BR}#== ${RT}${BY}${TITLE}${RT}  ${BR}[${RT}${B}${ROUTINE}${RT}${BR}]${RT}"; sleep 0.05
    echo -e "${BR}#== ============================================================${RT}"; sleep 0.05
    echo "${BR}[${RT}${BY}$(date +"%m-%d-%Y %H:%M:%S")${BR}]${RT} - ${BG}Starting :${RT} ${BC}${TITLE}${RT} ${BY}...${RT}"; sleep 0.05
  fi
}

# === Display 'Script' Completion 'Message' and 'Runtime' ===
# Single source of truth for the footer. Prints Completd + Time only - no
# leading separator. Never exits by itself - callers control the exit code.
#
sexit(){
  local end runtime minutes seconds
  end="$(date +%s)"
  runtime="$((end - SCRIPT_START))"
  minutes=$((runtime / 60))
  seconds=$((runtime % 60))
  echo "${BR}[${RT}${BY}$(date +"%m-%d-%Y %H:%M:%S")${BR}]${RT} - ${BG}Completd :${RT} ${BC}${TITLE}${RT} ${BY}...${RT}"; sleep 0.05
  echo -e "${BR}[${RT}${BY}$(date +"%m-%d-%Y %H:%M:%S")${BR}]${RT} - ${BG}Time     :${RT} ${BR}${minutes}m${RT}${BY}:${RT}${BR}${seconds}s${RT} ${BY}...${RT}\n"; sleep 0.05
}

# === Show a Bordered 'Section' 'Banner' ===
# Clears the screen and prints a three-line bordered title. Called by
# check_arguments for the usage banner and invalid-argument banner.
# Takes the section title as its only argument.
#
show_banner(){
  clear
  echo -e "\n${BR}#== ============================================================${RT}"; sleep 0.05
  echo -e "${BR}#== ${RT}$1${RT}"; sleep 0.05
  echo -e "${BR}#== ============================================================${RT}"; sleep 0.05
}

# === Fixed-Duration 'Wait' with 'Spinner' ===
# Blocks for <seconds> while animating a Braille spinner + elapsed counter.
# Use for post-start init waits where you just need to burn a known amount
# of time before health checks (e.g. wait_spinner 12).
#
# Usage:
#   wait_spinner 15 "Container initializing"
#   wait_spinner 30                            # uses default label
#
wait_spinner(){
  local wait_secs="${1:-10}"
  local label="${2:-Working}"
  local wf=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
  local wi=0 we=0 wt
  while [[ $we -lt $wait_secs ]]; do
    if [[ $we -lt 60 ]]; then wt="${we}s"; else wt="$(( we / 60 ))m:$(( we % 60 ))s"; fi
    printf '\r'"${BR}[${RT}${BY}$(date +"%m-%d-%Y %H:%M:%S")${BR}]${RT} - ${BY}Waiting  ${RT}${BG}:${RT} ${BC}${label}${RT} %s ${BY}%s${RT} ..." "${wf[$wi]}" "${wt}"
    wi=$(( (wi + 1) % 10 )); we=$(( we + 1 )); sleep 1
  done
  printf "\r\033[K"
}

# === Start a 'Background' 'Spinner' for Long-Running 'Operations' ===
# Launches a background loop that animates a Braille spinner + elapsed counter
# until stop_spinner is called. Use around unpredictable-duration ops like
# git clone, docker pull, make build, or docker stop.
#
# Usage:
#   start_spinner "Cloning" "jo-inc/camofox-browser"
#   git clone --quiet "${REPO_URL}" "${DEST}" > /dev/null 2>&1
#   git_exit=$?
#   stop_spinner
#
start_spinner(){
  local verb="${1:-Working}"
  local detail="${2:-}"
  {
    local sf=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local si=0 se=0 st
    while true; do
      if [[ $se -lt 60 ]]; then st="${se}s"; else st="$(( se / 60 ))m:$(( se % 60 ))s"; fi
      printf '\r'"${BR}[${RT}${BY}$(date +"%m-%d-%Y %H:%M:%S")${BR}]${RT} - ${BG}${verb}  ${RT}${BG}:${RT} ${BC}${detail}${RT} %s ${BY}%s${RT} ..." "${sf[$si]}" "${st}"
      si=$(( (si + 1) % 10 )); se=$(( se + 1 )); sleep 1
    done
  } &
  SPINNER_PID=$!
}

# === Stop the 'Background' 'Spinner' Cleanly ===
# Kills the spinner started by start_spinner and wipes the current line.
# Safe to call even if no spinner is running.
#
stop_spinner(){
  if [[ -n "${SPINNER_PID}" ]]; then
    kill "${SPINNER_PID}" 2>/dev/null
    wait "${SPINNER_PID}" 2>/dev/null
    SPINNER_PID=""
    printf "\r\033[K"
  fi
}

# === Show 'Usage' and Available 'Routines' ===
# Called from check_arguments when routine is 'usage' or invalid.
# Prints sectioned routines list, then exits 0 with a trailing blank line.
# Does NOT call sexit - plain 'bash <script>' with no arg should end clean,
# without the Completd/Time footer.
#
show_usage(){
  echo -e "${BR}#== ${RT}${BC}Available Routines:${RT}"; sleep 0.05
  echo -e "${BR}#== ${RT}${B}bash ${0##*/} install${RT}      ${BC}- Install and configure${RT}"; sleep 0.05
  echo -e "${BR}#== ${RT}${B}bash ${0##*/} uninstall${RT}    ${BC}- Remove everything${RT}"; sleep 0.05
  echo -e "${BR}#== ${RT}${B}bash ${0##*/} status${RT}       ${BC}- Show current status${RT}"; sleep 0.05
  echo ""; sleep 0.05
  exit 0
}

# === Validate 'Routine' Argument ===
# Prints usage banner + list on 'usage' or invalid input, then exits.
# For valid routines, cd's to the working directory and shows the start message.
#
check_arguments(){
  case "$1" in
    usage) show_banner "${BY}${TITLE}${RT}  ${BR}[${RT}${B}usage${RT}${BR}]${RT}" && show_usage ;;
    install|uninstall|status) ;;
    *) show_banner "${BY}Invalid Argument:${RT} ${BR}$1${RT}" && show_usage ;;
  esac
  cd "$W_DIR" || exit 1
  display_start_message
}

# === Main 'Execution' ===
check_arguments "$ROUTINE"

case "$ROUTINE" in
  install)
    echo "${BR}[${RT}${BY}$(date +"%m-%d-%Y %H:%M:%S")${BR}]${RT} - ${BG}Install  :${RT} ${BC}Running install routine${RT} ${BY}...${RT}"; sleep 0.05
    ;;
  uninstall)
    echo "${BR}[${RT}${BY}$(date +"%m-%d-%Y %H:%M:%S")${BR}]${RT} - ${BG}Remove   :${RT} ${BC}Running uninstall routine${RT} ${BY}...${RT}"; sleep 0.05
    ;;
  status)
    echo "${BR}[${RT}${BY}$(date +"%m-%d-%Y %H:%M:%S")${BR}]${RT} - ${BG}Status   :${RT} ${BC}Checking status${RT} ${BY}...${RT}"; sleep 0.05
    ;;
esac

sexit