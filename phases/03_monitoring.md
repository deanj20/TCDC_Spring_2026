# Phase 3: Monitoring

Goal: get immediate visibility with lightweight tools only.

Install:
```bash
sudo bash scripts/monitoring_setup.sh
```

Included tools:
- `net-tools`
- `htop`
- `tcpdump`
- `lsof`
- `fail2ban` (lightweight, enabled by script)

Useful commands:
```bash
netstat -tulnp
lsof -i
sudo tcpdump -i any -nn
sudo tcpdump -i any -nn port 22
sudo journalctl -xe
sudo journalctl -u ssh --since "15 min ago"
sudo fail2ban-client status
```

Why this works:
- Fast host/network visibility with minimal setup cost.
