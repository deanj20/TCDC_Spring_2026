# TCDC 2026 Blue Team Starter Repo

## TL;DR Strategy
Keep it simple and fast:
- Secure access first: rotate passwords for real users immediately.
- Lock down inbound traffic with a basic UFW baseline.
- Confirm required services still work after security changes.
- Start lightweight host/network monitoring and watch logs continuously.
- Run parallel: 3 Blue defenders harden/monitor assigned VMs while 1 Purple teammate performs rules-safe recon and reports findings.

Core principle: do small, safe, reversible changes that protect scoring services without breaking them.

## Team Roles (4 People)
- Blue 1: Own VM 1-2. Run phases 1-4, maintain service uptime.
- Blue 2: Own VM 3-4. Run phases 1-4, maintain service uptime.
- Blue 3: Own VM 5 (+ backup for busiest VM). Run phases 1-4.
- Purple 1: Run light offensive/recon on other teams, document access paths, share intel back to Blue.

## Phase Order
1. Initial access/password rotation ([phases/01_initial_access.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/01_initial_access.md))
2. Firewall baseline ([phases/02_firewall.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/02_firewall.md))
3. Monitoring setup ([phases/03_monitoring.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/03_monitoring.md))
4. Service validation ([phases/04_service_validation.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/04_service_validation.md))
5. Purple team actions ([phases/05_purple_team.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/05_purple_team.md))

## Quick Start Checklist
- Pick your VM ownership and confirm who is Purple.
- On each VM: `sudo bash scripts/change_passwords.sh`
- On each VM: `sudo bash scripts/basic_ufw.sh`
- On each VM: `sudo bash scripts/monitoring_setup.sh`
- On each VM: run service checks from phase 4.
- Start continuous monitoring (`journalctl`, `ss`/`netstat`, `lsof`, `tcpdump` as needed).

## 5-Minute Game Start Checklist
- Change passwords (skip `checker` and `blackteam`).
- Enable firewall baseline.
- Verify required services still work.
- Start monitoring.
- Assign and confirm team roles.
