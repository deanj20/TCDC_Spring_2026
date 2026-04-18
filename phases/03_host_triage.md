# Phase 03: Host Triage

Goal: look for persistence and obvious compromise without making risky automatic changes.

## Run
```bash
sudo bash scripts/host_triage.sh
```

The script gathers evidence only and saves a timestamped report in the current directory.

## Manual Review Checklist
- Unexpected admin users
- Unknown SSH keys in `/root` or user homes
- Suspicious cron jobs or cron drop-ins
- Odd services or unit files in `/etc/systemd/system`
- Reverse shells or weird parent and child process chains
- Recently modified startup files such as `.bashrc`, `.profile`, or `.bash_profile`
- New files in `/tmp`, `/var/tmp`, or `/dev/shm`
- Recently onboarded users with inconsistent shells, groups, or keys

## Review Notes
- Do not assume every anomaly is malicious.
- Document first and validate second.
- If you find something questionable, compare it to the host role before removing it.
- Preserve service uptime while you investigate.
