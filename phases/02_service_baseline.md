# Phase 02: Service Baseline

Goal: capture what the host looked like before you make bigger changes.

## Run
```bash
sudo bash scripts/service_baseline.sh
```

The script writes a timestamped baseline file in the current directory.

## What "Normal" Might Look Like
- The hostname matches the expected competition host.
- Listening ports fit the box role.
- Running and enabled services are mostly standard OS or expected application components.
- Recent logins line up with your own team activity.
- Disk usage is not unexpectedly full.

## What "Suspicious" Might Look Like
- Unknown listeners, especially high ports or services bound to all interfaces without a reason.
- Custom services or enabled units you do not recognize.
- Recent logins from accounts that should not be active.
- Strange process trees, duplicate shells, or network clients making outbound connections for no good reason.
- Disk usage spikes, especially under `/tmp`, `/var/tmp`, `/root`, or `/home`.

## Quick Validation Examples
```bash
curl -I http://localhost
curl -I http://<server-ip>
ftp <server-ip>
ssh <user>@<server-ip>
psql -h <server-ip> -U <db_user> -d <db_name> -c 'SELECT 1;'
```

## Operational Rule
- Validate the scored service after every hardening step, not just once.
- If a service breaks, back out the last change before making a second guess.
