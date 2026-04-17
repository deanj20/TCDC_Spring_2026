#!/usr/bin/env bash
set -u

# Change passwords for human/root accounts, but never touch protected competition users.
for user in $(awk -F: '($1=="root") || ($3>=1000 && $7 !~ /(nologin|false)$/) {print $1}' /etc/passwd); do
  case "$user" in
    checker|blackteam)
      echo "[skip] protected user: $user"
      continue
      ;;
  esac

  if id "$user" >/dev/null 2>&1; then
    echo
    echo "Set password for $user (use the shared team password)."
    passwd "$user"
  else
    echo "[skip] missing user: $user"
  fi
done
