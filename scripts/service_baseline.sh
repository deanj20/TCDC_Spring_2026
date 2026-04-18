#!/usr/bin/env bash
set -u

# Collect a quick service and host snapshot without making changes.

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
HOSTNAME_SHORT="$(hostname 2>/dev/null || echo unknown-host)"
OUTFILE="./service_baseline_${HOSTNAME_SHORT}_${TIMESTAMP}.txt"

append_header() {
  printf '\n===== %s =====\n' "$1" >>"$OUTFILE"
}

run_cmd() {
  local title="$1"
  shift

  append_header "$title"
  if ! "$@" >>"$OUTFILE" 2>&1; then
    printf '[warn] command failed: %s\n' "$*" >>"$OUTFILE"
  fi
}

run_shell() {
  local title="$1"
  local command_text="$2"

  append_header "$title"
  if ! bash -c "$command_text" >>"$OUTFILE" 2>&1; then
    printf '[warn] command failed: %s\n' "$command_text" >>"$OUTFILE"
  fi
}

{
  echo "TCDC service baseline"
  echo "Generated: $(date -Is)"
  echo "Host: $HOSTNAME_SHORT"
  echo "Collected by: $(id -un 2>/dev/null || echo unknown)"
} >"$OUTFILE"

run_cmd "hostname" hostname
run_cmd "ip addresses" ip a
run_cmd "listening ports" ss -tulpen
run_cmd "running services" systemctl list-units --type=service --state=running
run_cmd "enabled services" systemctl list-unit-files --type=service --state=enabled
run_shell "recent logins" "last -a | head -n 20"
run_cmd "disk usage" df -h
run_cmd "process list" ps auxfw

echo "Wrote baseline to $OUTFILE"
