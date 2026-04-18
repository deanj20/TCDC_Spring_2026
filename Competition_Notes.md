# TCDC 2026 Competition Notes

## Confirmed During The Intro Call

- Inbound traffic to blue-team hosts will be NATed behind one shared source IP.
- Red Team has already reviewed and accessed all team VMs before match start.
- Existing persistence, sleeper access, delayed triggers, or service-kill paths may already be present before the opening whistle.
- Competition Wazuh is already installed for monitoring. Do not tamper with it.
- Additional IDS can still be considered, but it should be lightweight, safe, and clearly worth the operational risk.
- Some recently onboarded employee accounts may be intentionally misconfigured or unusual.
- The named recently onboarded users from the packet are `chad`, `judy`, and `walter`.
- Our blue team is operating with 3 people to defend 5 VMs.

## Operational Implications

- Use firewall rules for port exposure control, not source-IP bans.
- Treat the opening response like incident response on already-touched hosts, not like first-time system setup.
- Password rotation is necessary but not sufficient. Follow it immediately with evidence collection and persistence hunting.
- Prioritize review of `authorized_keys`, `sudoers`, cron, systemd units and timers, shell startup files, suspicious listeners, and recently modified files.
- Review `chad`, `judy`, and `walter` early for bad shell settings, group membership, sudo access, keys, home directory permissions, and cron jobs.
- Prefer built-in visibility first. Add extra monitoring or IDS only after the first uptime-preserving hardening pass is complete.
- Avoid Wazuh changes entirely unless Black Team explicitly instructs otherwise.

## 3-Person Operating Model

- Person 1 owns `centurytree` and `aggiedrop`.
- Person 2 owns `bonfire` and `reveille-remote`.
- Person 3 owns `excel` first, then becomes the floating validator, IOC coordinator, and inject handler after `excel` is stable.
- Every host owner is still responsible for the first password rotation, baseline, and triage pass on their own boxes before asking for help elsewhere.
