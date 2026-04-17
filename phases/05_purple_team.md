# Phase 5: Purple Team (Rules-Safe)

Goal: gather actionable offensive intel for Blue without causing disruption.

Hard rules:
- No destruction.
- No locking out users.
- All actions must be reversible.

## Allowed-style activities

1. Check for default credentials on exposed services.
```bash
# Example only: single, limited test attempt
ssh admin@<target-ip>
```

2. Perform limited SSH auth attempts (no brute-force storms).
```bash
ssh <known-or-default-user>@<target-ip>
```

3. Document successful access paths and report immediately to Blue.
- Record target, username, method, timestamp.
- Do not modify target configs unless rules explicitly allow.

4. Optional reversible persistence demo (commented example, use only if rules permit).
```bash
# sudo useradd -m -s /bin/bash audit_backdoor
# sudo passwd audit_backdoor
# sudo userdel -r audit_backdoor   # rollback
```

Output expected from Purple:
- Short list of weak creds/default creds found.
- Which services were exposed.
- Immediate defensive fix recommendations.
