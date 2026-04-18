#!/usr/bin/env bash
set -eu

# Install a small set of understandable monitoring tools.
# Keep the opening response lightweight.

if [ "$(id -u)" -ne 0 ]; then
  echo "Run with sudo or as root."
  exit 1
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update
apt-get install -y net-tools htop lsof tcpdump jq

echo
echo "Installed: net-tools htop lsof tcpdump jq"

if dpkg -s auditd >/dev/null 2>&1; then
  echo "[info] auditd is already installed on this host. Review it before changing anything."
else
  echo "[info] auditd was not installed automatically. Add it only if the host is stable and the team agrees."
fi

echo "[info] aide is not initialized by this script."
echo "[info] Fail2Ban is not a core defense here because inbound traffic is NATed behind one IP."

echo
echo "Useful live commands:"
echo "  watch -n 2 'ss -tulpen'"
echo "  watch -n 2 'who'"
echo "  journalctl -f"
echo "  tail -f /var/log/auth.log"
echo "  tcpdump -ni any"
echo "  lsof -i -P -n"
