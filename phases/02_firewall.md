# Phase 2: Firewall (UFW)

Goal: allow required inbound services, deny other inbound traffic.

Competition constraint:
- Do not apply broad outbound blocking.

Run:
```bash
sudo bash scripts/basic_ufw.sh
```

What it does:
- `ufw default deny incoming`
- `ufw default allow outgoing`
- Allows ports `22`, `80`, `443`, `21`
- Optionally allows `5432` (PostgreSQL) only if needed
- Enables UFW

Check status:
```bash
sudo ufw status verbose
```
