# Phase 01: Passwords

Goal: remove known easy access quickly without breaking competition accounts.

## Rules
- Do not change `checker`.
- Do not change `blackteam`.
- Use one strong shared team password for speed, then store it offline.
- Do not paste the shared password into visible team chat or tickets.
- Skip users that do not exist on the current host.

## Default User List
- `root`
- `alice`
- `bob`
- `craig`
- `chad`
- `trudy`
- `mallory`
- `mike`
- `yves`
- `judy`
- `sybil`
- `walter`
- `wendy`

## Run
```bash
sudo bash scripts/change_passwords.sh
```

## Override The User List If Needed
```bash
sudo bash scripts/change_passwords.sh root alice bob mike
```

## After Rotation
- Save the password offline.
- Confirm you can still access the host through your intended management path.
- Move straight into service baseline and service validation.
