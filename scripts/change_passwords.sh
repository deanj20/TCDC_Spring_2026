#!/usr/bin/env bash
set -u

# Rotate a simple shared password across the known competition accounts.
# Protected users are always skipped even if they are passed on the command line.

if [ "$(id -u)" -ne 0 ]; then
  echo "Run with sudo or as root."
  exit 1
fi

DEFAULT_USERS=(
  root
  alice
  bob
  craig
  chad
  trudy
  mallory
  mike
  yves
  judy
  sybil
  walter
  wendy
)

if [ "$#" -gt 0 ]; then
  USERS=("$@")
else
  USERS=("${DEFAULT_USERS[@]}")
fi

echo "Protected users will be skipped: checker blackteam"
echo "Save the shared password offline. Do not paste it into visible team chat."
echo

while true; do
  read -r -s -p "Enter the new shared password: " SHARED_PASSWORD
  echo
  read -r -s -p "Re-enter the new shared password: " SHARED_PASSWORD_CONFIRM
  echo

  if [ -z "$SHARED_PASSWORD" ]; then
    echo "[warn] Password cannot be empty."
    continue
  fi

  if [ "$SHARED_PASSWORD" != "$SHARED_PASSWORD_CONFIRM" ]; then
    echo "[warn] Passwords did not match. Try again."
    continue
  fi

  break
done

SUCCESS_COUNT=0
SKIP_COUNT=0
FAIL_COUNT=0

for USERNAME in "${USERS[@]}"; do
  case "$USERNAME" in
    checker|blackteam)
      echo "[skip] protected user: $USERNAME"
      SKIP_COUNT=$((SKIP_COUNT + 1))
      continue
      ;;
  esac

  if ! id "$USERNAME" >/dev/null 2>&1; then
    echo "[skip] missing user: $USERNAME"
    SKIP_COUNT=$((SKIP_COUNT + 1))
    continue
  fi

  if printf '%s:%s\n' "$USERNAME" "$SHARED_PASSWORD" | chpasswd; then
    echo "[ ok ] password updated: $USERNAME"
    SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
  else
    echo "[fail] password update failed: $USERNAME"
    FAIL_COUNT=$((FAIL_COUNT + 1))
  fi
done

unset SHARED_PASSWORD
unset SHARED_PASSWORD_CONFIRM

echo
echo "Summary: $SUCCESS_COUNT updated, $SKIP_COUNT skipped, $FAIL_COUNT failed."
