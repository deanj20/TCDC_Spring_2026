# Phase 05: Monitoring

Goal: get lightweight visibility without slowing the team down or making unnecessary opening-window changes.

## Run
```bash
sudo bash scripts/monitoring_setup.sh
sudo bash scripts/monitoring_setup.sh --install-tools
```

Default mode makes no package changes. Add `--install-tools` later if the host is stable and you want a few extra utilities.

## Focus Areas
- Auth failures
- Process changes
- New listeners
- Modified files
- Suspicious service restarts

Because inbound traffic appears from one NAT IP, source-IP blocking is not the main signal. Watch host behavior, not just connection counts.

## Useful Live Commands
```bash
watch -n 2 'ss -tulpen'
watch -n 2 'who'
journalctl -f
tail -f /var/log/auth.log
tcpdump -ni any
lsof -i -P -n
```

## Notes
- Fail2Ban is not a primary defense here.
- Assume Red Team may already have footholds. Watch for delayed triggers, unexpected restarts, and new listeners.
- Do not tamper with Wazuh.
- `auditd` can be useful if it is already present and stable, but do not make it the opening move.
- `aide` can help later, but do not initialize it automatically in the middle of the opening response.
- Zeek and Suricata are optional later additions. Host triage and service validation come first.
