#!/usr/bin/env bash
set -eu

# Print monitoring guidance by default.
# Install a small set of extra tools only when explicitly requested.

usage() {
  cat <<'EOF'
Usage:
  sudo bash scripts/monitoring_setup.sh
  sudo bash scripts/monitoring_setup.sh --install-tools

Default mode makes no package changes.
EOF
}

if [ "$(id -u)" -ne 0 ]; then
  echo "Run with sudo or as root."
  exit 1
fi

INSTALL_TOOLS=0

for ARG in "$@"; do
  case "$ARG" in
    --install-tools)
      INSTALL_TOOLS=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $ARG"
      usage
      exit 1
      ;;
  esac
done

if [ "$INSTALL_TOOLS" -eq 1 ]; then
  export DEBIAN_FRONTEND=noninteractive

  apt-get update
  apt-get install -y net-tools htop lsof tcpdump jq

  echo
  echo "Installed: net-tools htop lsof tcpdump jq"
else
  echo "[info] No package changes made."
  echo "[info] Use --install-tools later if the host is stable and you want extra utilities."
fi

echo
echo "[info] Assume Red Team may already have footholds on these hosts."
echo "[info] Watch for delayed triggers, restarts, and new listeners."
echo "[info] Do not tamper with competition Wazuh."

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
