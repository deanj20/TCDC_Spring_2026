# Phase 4: Service Validation

Goal: confirm scoring services still work after hardening.

## HTTP/HTTPS
```bash
curl -I http://localhost
curl -Ik https://localhost
curl -I http://<server-ip>
```

## FTP
```bash
ftp <server-ip>
# log in, then run: ls
# then quit
```

## SSH
```bash
ssh <user>@<server-ip>
# confirm login works, then exit
```

## PostgreSQL
```bash
psql -h <server-ip> -U <db_user> -d <db_name> -c 'SELECT 1;'
```

Tip:
- If a service check fails after firewall changes, verify the service is running and confirm its port is explicitly allowed.
