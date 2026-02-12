# Day 05 – Linux Troubleshooting Runbook

Today I practiced a focused Linux troubleshooting drill instead of just running commands randomly.

The goal was simple:
Pick one running service and go through a proper health check — just like in a real production scenario.

Target service for this drill: **SSH (sshd)**

---

## 1️ Environment Details

First, I confirmed the system environment.

```bash
uname -a
Observed: Ubuntu running on WSL2 with Linux kernel 5.x.

cat /etc/os-release
Observed: Ubuntu 22.04 LTS (Jammy Jellyfish).
```
--- 
2 . Filesystem Sanity Check
Created a temporary folder to confirm write access:
```bash
mkdir /tmp/runbook-demo
cp /etc/hosts /tmp/runbook-demo/hosts-copy
ls -l /tmp/runbook-demo
```
Observed:

- Folder created successfully.
- File copied without permission errors.
- Filesystem is working normally.
---
3. CPU & Memory Snapshot
First, I found the SSH process ID:
```bash
pgrep sshd
```
Then checked resource usage:
```bash
ps -o pid,pcpu,pmem,comm -p <PID>
```
Observed:
- Very low CPU usage.
- Minimal memory usage.
- Service appears stable.

Checked overall memory: free -h
Observed:
- Sufficient free memory available.
- No signs of memory pressure.

 ---
 
4.Disk & IO Snapshot :
Checked disk usage: df -h
Observed:
- Root partition not close to full.
- No storage risk.

Checked log directory size:du -sh /var/log

Observed:
- Log size within normal limits.
- No abnormal growth.
---
5. Network Snapshot
Checked if SSH is listening:ss -tulpn | grep ssh
Observed:
- SSH listening on port 22.
- Service properly bound.
---
6. logs Review:
  - Checked recent SSH logs:journalctl -u ssh -n 50
Observed:
- No recent errors.
- Normal service activity.

---
If This Worsens (Next Steps) :
- If CPU spikes or service becomes unstable:
  
1.Restart service carefully and monitor resource usage.

2.Increase SSH log verbosity in /etc/ssh/sshd_config.

3.Use strace -p <PID> to trace system calls.

4.Check for repeated failed login attempts.

5.Monitor with top or htop for sustained spikes.

