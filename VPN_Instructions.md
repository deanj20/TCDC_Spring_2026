# TxCR VPN (Linux Quick Steps)

## 1. Install `gpclient` (GlobalProtect OpenConnect wrapper)

```bash
git clone https://github.com/yuezk/GlobalProtect-openconnect.git
cd GlobalProtect-openconnect
./scripts/build.sh
sudo ./scripts/install.sh
```

## 2. Connect to VPN

SSO should open in your browser.

```bash
sudo gpclient connect vpn.txcr.dev
```

## 3. Verify the tunnel is up

```bash
ip a | grep tun
ping <target VM IP>
```

## 4. SSH into your assigned VM

```bash
ssh <username>@<VM IP>
```

## 5. If SSH fails

- Ensure `sshd` is running on the VM:

```bash
sudo systemctl status ssh
```

- Ensure port `22` is open in `ufw`/`nftables`.
