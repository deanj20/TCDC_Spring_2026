# Phase 1: Initial Access (Passwords)

Goal: remove easy attacker access quickly without breaking competition accounts.

Rules:
- Do not modify `checker`.
- Do not modify `blackteam`.
- Use one shared strong team password for speed/simplicity.
- Do not hardcode passwords in scripts.

Run:
```bash
sudo bash scripts/change_passwords.sh
```

Manual fallback:
```bash
sudo passwd <username>
```

Why this works:
- Stops reused/default credentials fast.
- Keeps process human-confirmed and reversible.
