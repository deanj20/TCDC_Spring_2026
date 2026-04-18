#!/usr/bin/env bash
set -u

# Safe UFW helper for role-based port control.
# Default mode is dry-run. Use --apply to make changes.

usage() {
  cat <<'EOF'
Usage:
  sudo bash scripts/basic_ufw.sh [--apply] <port> [port ...]

Examples:
  sudo bash scripts/basic_ufw.sh 22 80
  sudo bash scripts/basic_ufw.sh --apply 22 80
  sudo bash scripts/basic_ufw.sh --apply 21
EOF
}

if [ "$(id -u)" -ne 0 ]; then
  echo "Run with sudo or as root."
  exit 1
fi

APPLY_MODE=0
ALLOWED_PORTS=()

for ARG in "$@"; do
  case "$ARG" in
    --apply)
      APPLY_MODE=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      if [[ "$ARG" =~ ^[0-9]+$ ]] && [ "$ARG" -ge 1 ] && [ "$ARG" -le 65535 ]; then
        ALLOWED_PORTS+=("$ARG")
      else
        echo "Invalid port: $ARG"
        usage
        exit 1
      fi
      ;;
  esac
done

if [ "${#ALLOWED_PORTS[@]}" -eq 0 ]; then
  echo "Provide at least one allowed TCP port."
  usage
  exit 1
fi

echo "Inbound NAT note: use UFW for port control only, not source-IP blocking."
echo "Requested allowed TCP ports: ${ALLOWED_PORTS[*]}"

if ! printf '%s\n' "${ALLOWED_PORTS[@]}" | grep -qx '22'; then
  echo "[warn] Port 22 is not in the allow list. Confirm you have console access or another safe admin path."
fi

if [ "$APPLY_MODE" -ne 1 ]; then
  echo
  echo "Dry-run mode. Commands that would run:"
  echo "1. ufw --force reset"
  echo "2. ufw default deny incoming"
  echo "3. ufw default allow outgoing"

  STEP=4
  for PORT in "${ALLOWED_PORTS[@]}"; do
    echo "$STEP. ufw allow ${PORT}/tcp"
    STEP=$((STEP + 1))
  done

  echo "$STEP. ufw --force enable"
  echo "$((STEP + 1)). ufw status numbered"
  echo
  echo "Re-run with --apply when you are ready."
  exit 0
fi

echo
echo "Applying UFW rules..."
ufw --force reset
echo "1. Reset existing UFW rules"

ufw default deny incoming
echo "2. Set default deny incoming"

ufw default allow outgoing
echo "3. Set default allow outgoing"

STEP=4
for PORT in "${ALLOWED_PORTS[@]}"; do
  ufw allow "${PORT}/tcp"
  echo "$STEP. Allowed ${PORT}/tcp"
  STEP=$((STEP + 1))
done

ufw --force enable
echo "$STEP. Enabled UFW"

echo "$((STEP + 1)). Current status"
ufw status numbered

echo
echo "Validate the scored service immediately after this change."
