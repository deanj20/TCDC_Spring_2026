#!/usr/bin/env bash
set -eu

# Lightweight monitoring toolset only.
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y net-tools htop tcpdump lsof fail2ban
systemctl enable --now fail2ban

echo
echo "Monitoring quick commands:"
echo "  netstat -tulnp"
echo "  lsof -i"
echo "  tcpdump -i any -nn"
echo "  tcpdump -i any -nn port 22"
echo "  journalctl -xe"
echo "  journalctl -u ssh --since '15 min ago'"
echo "  fail2ban-client status"
