#!/usr/bin/env bash
set -eu

# Simple inbound baseline for TCDC-style service protection.
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 21/tcp

read -r -p "Allow PostgreSQL port 5432/tcp on this VM? (y/N): " allow_pg
if [[ "$allow_pg" =~ ^[Yy]$ ]]; then
  ufw allow 5432/tcp
fi

ufw --force enable
ufw status verbose
