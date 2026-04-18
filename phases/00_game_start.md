# Phase 00: Game Start

## Immediate Actions At 9:00
- Split the five hosts across the team before touching anything.
- Log in to every box and confirm the hostname and service role.
- Keep one shared offline note with host owner, current access path, and service status.
- Treat every box as pre-compromised until triage proves otherwise.

## Intro Call Confirmations
- Inbound traffic is NATed behind one shared source IP.
- Red Team already reviewed and accessed the VMs before match start.
- Assume sleeper persistence or delayed service disruption may already be present.
- Competition Wazuh is already installed. Do not tamper with it.
- Recently onboarded accounts may be intentionally misconfigured. Check `chad`, `judy`, and `walter` early.

## First 5 Minutes
- Confirm access to each host through SSH or console before making changes.
- Rotate passwords first, except `checker` and `blackteam`.
- Run the service baseline script on each host.
- Validate the scored service before moving to firewall changes.
- Start IOC triage collection early so you can document persistence before editing it.
- Review the recently onboarded accounts and management access paths before trusting the host.

## What NOT To Do
- Do not touch `blackteam`.
- Do not touch `checker`.
- Do not blindly `apt upgrade` everything.
- Do not reboot unless necessary for recovery.
- Do not enable aggressive blocking before validating services.
- Do not delete suspicious files, keys, users, or services before documenting them.
- Do not assume Fail2Ban or source-IP bans will help when all inbound traffic is NATed behind one IP.
- Do not tamper with competition Wazuh.
- Do not make heavyweight IDS changes before your first scoring-preserving hardening pass.

## Host Split For 3 People
- Person 1: `centurytree` and `aggiedrop`
- Person 2: `bonfire` and `reveille-remote`
- Person 3: `excel`, then cross-host validation, IOC comparison, and inject handling after `excel` is stable

## Order Of Work Per Host
1. Passwords
2. Service baseline
3. Service validation
4. Host triage
5. Firewall tightening
6. Service validation again
7. Monitoring
