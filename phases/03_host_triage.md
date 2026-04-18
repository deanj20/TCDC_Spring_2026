# Phase 03: Host Triage

Goal: look for persistence and obvious compromise without making risky automatic changes.
Assume Red Team already had pre-game access and may have left delayed disruption paths behind.

## Run
```bash
sudo bash scripts/host_triage.sh
```

The script gathers evidence only and saves a timestamped report in the current directory.

## Manual Review Checklist
- Unexpected admin users
- Unknown SSH keys in `/root` or user homes
- Unexpected entries in `/etc/sudoers` or `/etc/sudoers.d`
- Suspicious cron jobs or cron drop-ins
- Odd services or unit files in `/etc/systemd/system`
- Reverse shells or weird parent and child process chains
- Recently modified startup files such as `.bashrc`, `.profile`, or `.bash_profile`
- New files in `/tmp`, `/var/tmp`, or `/dev/shm`
- Recently onboarded users with inconsistent shells, groups, keys, home permissions, or sudo access

## High-Priority Accounts
- Check `chad`, `judy`, and `walter` first.
- Compare their shell, groups, home directory permissions, `authorized_keys`, cron, and sudo access against what the host role actually needs.
- If one of these accounts is suspicious, document it before removing access so you do not break a scored workflow by accident.

## Review Notes
- Do not assume every anomaly is malicious.
- Document first and validate second.
- If you find something questionable, compare it to the host role before removing it.
- Preserve service uptime while you investigate.
