# Phase 04: Firewall

Goal: use UFW for service and port control only.

Because inbound traffic is NATed behind one source IP, do not build strategy around attacker-IP bans.

## Safe Run Pattern
```bash
sudo bash scripts/basic_ufw.sh 22 80
sudo bash scripts/basic_ufw.sh --apply 22 80
```

Default mode is dry-run. Add `--apply` only after you are ready.

## Role To Port Mapping
- `centurytree`: `80` and `443` only if the host really serves HTTPS; include `22` if you need SSH management
- `aggiedrop`: `21` plus any confirmed scored custom port; include `22` if you need SSH management
- `bonfire`: `80` and `443` only if required; include `22` if you need SSH management
- `reveille-remote`: `22`
- `excel`: `5432` only if scoring or remote service checks require it; include `22` if you need SSH management

## Rules
- Deny other inbound traffic.
- Leave outbound traffic allowed.
- Do not assume every box needs the same port list.
- Validate the scored service immediately after enabling UFW.

## Validate Right After Apply
```bash
curl -I http://<server-ip>
ftp <server-ip>
ssh <user>@<server-ip>
psql -h <server-ip> -U <db_user> -d <db_name> -c 'SELECT 1;'
```
