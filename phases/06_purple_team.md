# Phase 06: Purple Team

Only start this phase after your own boxes are stable.

## Hard Rules
- Actions must be reversible.
- Do not brick hosts.
- Do not lock out teams.
- Do not attack black team tooling.
- Do not attack Wazuh or `auditd`.
- Do not use destructive persistence.

## Safe Goals
- Check whether default passwords still appear to work where competition rules allow.
- Verify exposed services and access paths without disrupting them.
- Document opportunities and report them back to your own team quickly.
- Notify your team before taking any action beyond basic validation.

## Keep It Tight
- Use single, manual validation attempts only.
- Stop after confirming whether access is possible.
- Record target, service, username tested, result, and timestamp.
- Do not escalate, alter, plant, or hide anything on another team host.
