# TCDC 2026 Blue Team Starter Repo

This repo is a field guide for a TCDC-style Ubuntu environment with 5 hosts per team.
Assume the boxes may already be compromised. Keep changes simple, reversible, and easy to explain.

## One-Page Strategy
- Rotate passwords immediately, except for `checker` and `blackteam`.
- Preserve scoring before hardening: baseline each host and validate its scored service after every change.
- Treat every host as potentially pre-compromised: collect evidence first, then decide what is safe to change.
- Use UFW for service and port control only. Do not build strategy around source-IP blocking because inbound traffic is NATed behind one address.
- Keep outbound traffic allowed. Broad outbound deny is against the rules.
- Use lightweight monitoring to catch auth failures, new listeners, service restarts, and suspicious process changes.
- Do purple recon only after your own hosts are stable.

## Role Assignment For 4 People
- Person 1: VM hardening lead for `centurytree` and `aggiedrop`.
- Person 2: VM hardening lead for `bonfire` and `reveille-remote`.
- Person 3: VM hardening lead for `excel` plus service validation support across all hosts.
- Person 4: IOC hunting coordinator, monitoring lead, note keeper, and limited purple recon lead after blue stability.

## First 15 Minutes Plan
- Split the five hosts immediately and confirm who owns each box.
- Log in to every host and confirm you still have a management path before making changes.
- Run password rotation first on each host.
- Collect a quick service baseline and verify the scored service still works.
- Collect host triage output before making riskier changes.
- Apply only role-appropriate UFW ports.
- Validate the scored service again.
- Start live monitoring and only then allow limited purple recon.

## Parallel Execution Model
- Persons 1-3 work their assigned hosts in parallel using the same order: passwords, service baseline, service validation, host triage, firewall, validation, monitoring.
- Person 3 retests services after firewall changes so host owners do not guess whether scoring is still intact.
- Person 4 gathers IOC notes, compares triage outputs across hosts, watches for suspicious changes, and keeps the team focused on evidence instead of guesswork.
- Purple activity starts only after all five hosts have completed the first blue pass.

## 5-Minute Checklist
- Log in to all boxes and confirm the hostnames match your assignment.
- Verify you have at least one safe way back in before touching firewall rules.
- Rotate passwords except `checker` and `blackteam`.
- Capture a service baseline on each box.
- Confirm the scored service still answers locally and remotely if needed.
- Start IOC triage collection so you have evidence before changing suspicious items.

## DO NOT BREAK SCORING
- Do not change, remove, disable, lock, or expire `blackteam`.
- Do not change, remove, disable, lock, or expire `checker`.
- Do not blindly run `apt upgrade`, `dist-upgrade`, or mass package changes during the opening window.
- Do not reboot unless a specific recovery step requires it.
- Do not delete suspicious files, users, keys, or services before documenting them.
- Do not rely on Fail2Ban or source-IP bans as a primary control when all inbound traffic appears from one NAT IP.
- Do not enable aggressive blocking before validating the service on that host.
- Do not apply broad outbound deny rules.

## Repo Map
- [phases/00_game_start.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/00_game_start.md)
- [phases/01_passwords.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/01_passwords.md)
- [phases/02_service_baseline.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/02_service_baseline.md)
- [phases/03_host_triage.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/03_host_triage.md)
- [phases/04_firewall.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/04_firewall.md)
- [phases/05_monitoring.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/05_monitoring.md)
- [phases/06_purple_team.md](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/phases/06_purple_team.md)
- [scripts/change_passwords.sh](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/scripts/change_passwords.sh)
- [scripts/service_baseline.sh](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/scripts/service_baseline.sh)
- [scripts/host_triage.sh](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/scripts/host_triage.sh)
- [scripts/basic_ufw.sh](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/scripts/basic_ufw.sh)
- [scripts/monitoring_setup.sh](/home/jeremydean/CyberSec/TCDC_2026/TCDC_Spring_2026/scripts/monitoring_setup.sh)

## FIRST 15 MINUTES
1. log in to all boxes
2. rotate passwords except `checker` and `blackteam`
3. baseline services
4. validate scored services
5. collect IOC triage output
6. apply role-appropriate UFW ports
7. validate services again
8. start live monitoring
9. then begin limited purple recon
