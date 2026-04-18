#!/usr/bin/env bash
set -u

# Evidence-only triage collection for potentially pre-compromised hosts.
# This script does not delete, disable, or change anything.

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
HOSTNAME_SHORT="$(hostname 2>/dev/null || echo unknown-host)"
OUTFILE="./host_triage_${HOSTNAME_SHORT}_${TIMESTAMP}.txt"

append_header() {
  printf '\n===== %s =====\n' "$1" >>"$OUTFILE"
}

run_cmd() {
  local title="$1"
  shift

  append_header "$title"
  if ! "$@" >>"$OUTFILE" 2>&1; then
    printf '[warn] command failed: %s\n' "$*" >>"$OUTFILE"
  fi
}

run_shell() {
  local title="$1"
  local command_text="$2"

  append_header "$title"
  if ! bash -c "$command_text" >>"$OUTFILE" 2>&1; then
    printf '[warn] command failed: %s\n' "$command_text" >>"$OUTFILE"
  fi
}

{
  echo "TCDC host triage"
  echo "Generated: $(date -Is)"
  echo "Host: $HOSTNAME_SHORT"
  echo "Collected by: $(id -un 2>/dev/null || echo unknown)"
  if [ "$(id -u)" -ne 0 ]; then
    echo "Warning: not running as root. Some sections may be incomplete."
  fi
} >"$OUTFILE"

run_cmd "local users" getent passwd
run_cmd "sudo group members" getent group sudo
run_shell "sudoers files" "sed -n '1,200p' /etc/sudoers 2>/dev/null; for f in /etc/sudoers.d/*; do [ -f \"\$f\" ] || continue; echo \"--- \$f ---\"; sed -n '1,200p' \"\$f\"; echo; done"
run_shell "recently onboarded user details" "for user in chad judy walter; do if id \"\$user\" >/dev/null 2>&1; then echo \"--- \$user ---\"; getent passwd \"\$user\"; id \"\$user\"; groups \"\$user\"; passwd -S \"\$user\" 2>/dev/null || true; home=\$(getent passwd \"\$user\" | cut -d: -f6); if [ -n \"\$home\" ] && [ -d \"\$home\" ]; then ls -ld \"\$home\"; find \"\$home\" -maxdepth 2 \\( -name authorized_keys -o -name .bashrc -o -name .profile -o -name .bash_profile \\) -type f 2>/dev/null | sort | while read -r file; do echo \"--- \$file ---\"; sed -n '1,200p' \"\$file\"; echo; done; else echo '[info] home directory missing or not a directory'; fi; echo; fi; done"
run_shell "authorized_keys files and contents" "find /root /home -name authorized_keys -type f 2>/dev/null | sort | while read -r file; do echo \"--- \$file ---\"; sed -n '1,200p' \"\$file\"; echo; done"
run_shell "system cron files" "ls -la /etc/cron* 2>/dev/null"
run_shell "system crontab" "if [ -f /etc/crontab ]; then sed -n '1,200p' /etc/crontab; else echo '[info] /etc/crontab not present'; fi"
run_shell "user crontabs" "getent passwd | cut -d: -f1 | while read -r user; do echo \"--- crontab for \$user ---\"; crontab -u \"\$user\" -l 2>/dev/null || echo '[info] no crontab or unreadable'; echo; done"
run_cmd "systemd services" systemctl list-units --type=service --all
run_cmd "systemd service files" systemctl list-unit-files --type=service
run_shell "custom systemd paths" "find /etc/systemd/system -maxdepth 2 -type f 2>/dev/null | sort"
run_cmd "systemd timers" systemctl list-timers --all
run_shell "rc.local" "if [ -f /etc/rc.local ]; then sed -n '1,200p' /etc/rc.local; else echo '[info] /etc/rc.local not present'; fi"
run_shell "files in tmp areas" "find /tmp /var/tmp /dev/shm -maxdepth 2 -type f -printf '%TY-%Tm-%Td %TH:%TM %u %g %m %p\n' 2>/dev/null | sort"
run_shell "world-writable files in sensitive paths" "find /etc /usr/local /opt /root /home -xdev -maxdepth 4 -type f -perm -0002 -printf '%M %u %g %p\n' 2>/dev/null | sort"
run_shell "setuid and setgid files" "find / -xdev \\( -perm -4000 -o -perm -2000 \\) -type f -printf '%M %u %g %p\n' 2>/dev/null | sort"
run_shell "recent file changes in key paths" "find /etc /usr/local /opt /root /home -mtime -7 -printf '%TY-%Tm-%Td %TH:%TM %u %g %p\n' 2>/dev/null | sort"
run_shell "shell startup files" "find /root /home -maxdepth 2 \\( -name .bashrc -o -name .profile -o -name .bash_profile \\) -type f 2>/dev/null | sort | while read -r file; do echo \"--- \$file ---\"; sed -n '1,200p' \"\$file\"; echo; done"
run_cmd "network connections" ss -plant
run_cmd "listening processes" ss -tulpen
run_cmd "process list" ps auxfw
run_shell "installed packages summary" "dpkg-query -W -f='\${binary:Package}\t\${Version}\n' 2>/dev/null | sort"

echo "Wrote triage to $OUTFILE"
