# TCDC 2026 Blue Team Starter Repo

This repo is a field guide for a TCDC-style Ubuntu environment with 5 hosts per team.
Assume the boxes may already be compromised. Keep changes simple, reversible, and easy to explain.

## Competition Notes
- Intro call confirmed that inbound traffic is NATed behind one shared source IP.
- Intro call confirmed that Red Team already had access to review these VMs before the match, so expect existing persistence and delayed disruption paths.
- Recently onboarded employee accounts deserve extra scrutiny, especially `chad`, `judy`, and `walter`.
- Wazuh is already present for competition monitoring. Do not tamper with it. Consider only lightweight additional IDS after the first stabilization pass.
- The current operating assumption is a 3-person blue team defending 5 VMs.

## One-Page Strategy
- Rotate passwords immediately, except for `checker` and `blackteam`.
- Preserve scoring before hardening: baseline each host and validate its scored service after every change.
- Treat every host as pre-compromised from minute 0. Red Team has already touched the environment, so hunt for persistence and delayed triggers early.
- Review the recently onboarded accounts early, especially `chad`, `judy`, and `walter`, for bad groups, keys, shells, cron, or home permissions.
- Use UFW for service and port control only. Do not build strategy around source-IP blocking because inbound traffic is NATed behind one address.
- Keep outbound traffic allowed. Broad outbound deny is against the rules.
- Use built-in visibility first to catch auth failures, new listeners, service restarts, and suspicious process changes. Consider extra IDS later, but do not interfere with Wazuh.
- Do purple recon only after your own hosts are stable.

## Role Assignment For 3 People
- Person 1: VM hardening lead for `centurytree` and `aggiedrop`.
- Person 2: VM hardening lead for `bonfire` and `reveille-remote`.
- Person 3: VM hardening lead for `excel`, then floating service validator, IOC coordinator, and inject handler after `excel` is stable.

## First 15 Minutes Plan
- Split the five hosts immediately and confirm primary and backup owner for each box.
- Log in to every host and confirm you still have a management path before making changes.
- Run password rotation first on each host.
- Collect a quick service baseline and verify the scored service still works.
- Collect host triage output before making riskier changes, with special attention to persistence, startup paths, and recently onboarded accounts.
- Apply only role-appropriate UFW ports.
- Validate the scored service again.
- Start live monitoring with built-in tools. Consider additional IDS only after the first blue pass is stable, and do not touch Wazuh.

## Parallel Execution Model
- Persons 1 and 2 each work two hosts in parallel using the same order: passwords, service baseline, service validation, host triage, firewall, validation, monitoring.
- Person 3 secures `excel` first, then retests services after firewall changes so host owners do not guess whether scoring is still intact.
- Person 3 also consolidates IOC notes, compares triage outputs across hosts, and tracks inject intake once `excel` is stable.
- Purple activity starts only after all five hosts have completed the first blue pass and the inject queue is under control.

## 5-Minute Checklist
- Log in to all boxes and confirm the hostnames match your assignment.
- Verify you have at least one safe way back in before touching firewall rules.
- Rotate passwords except `checker` and `blackteam`.
- Capture a service baseline on each box.
- Confirm the scored service still answers locally and remotely if needed.
- Start IOC triage collection so you have evidence before changing suspicious items.
- Check `chad`, `judy`, and `walter` early for odd groups, keys, sudo access, or startup entries.

## DO NOT BREAK SCORING
- Do not change, remove, disable, lock, or expire `blackteam`.
- Do not change, remove, disable, lock, or expire `checker`.
- Do not blindly run `apt upgrade`, `dist-upgrade`, or mass package changes during the opening window.
- Do not reboot unless a specific recovery step requires it.
- Do not delete suspicious files, users, keys, or services before documenting them.
- Do not rely on Fail2Ban or source-IP bans as a primary control when all inbound traffic appears from one NAT IP.
- Do not enable aggressive blocking before validating the service on that host.
- Do not apply broad outbound deny rules.
- Do not tamper with competition Wazuh.

## Repo Map
- [Competition_Notes.md](Competition_Notes.md)
- [VPN_Instructions.md](VPN_Instructions.md)
- [phases/00_game_start.md](phases/00_game_start.md)
- [phases/01_passwords.md](phases/01_passwords.md)
- [phases/02_service_baseline.md](phases/02_service_baseline.md)
- [phases/03_host_triage.md](phases/03_host_triage.md)
- [phases/04_firewall.md](phases/04_firewall.md)
- [phases/05_monitoring.md](phases/05_monitoring.md)
- [phases/06_purple_team.md](phases/06_purple_team.md)
- [scripts/change_passwords.sh](scripts/change_passwords.sh)
- [scripts/service_baseline.sh](scripts/service_baseline.sh)
- [scripts/host_triage.sh](scripts/host_triage.sh)
- [scripts/basic_ufw.sh](scripts/basic_ufw.sh)
- [scripts/monitoring_setup.sh](scripts/monitoring_setup.sh)

## FIRST 15 MINUTES
1. log in to all boxes
2. rotate passwords except `checker` and `blackteam`
3. baseline services
4. validate scored services
5. collect IOC triage output with focus on persistence and new employee accounts
6. apply role-appropriate UFW ports
7. validate services again
8. start live monitoring with built-in tools first
9. then begin limited purple recon
