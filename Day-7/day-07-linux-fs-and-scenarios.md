# Day 7/90 – Linux File System Hierarchy & Scenario-Based Practice

Today's goal was to understand where things live in Linux and practice troubleshooting like a DevOps engineer.

## Part 1: Linux File System Hierarchy

### Core Directories (Must Know)
- **`/`** (root) - The starting point of everything
- **`/home`** - User home directories
- **`/root`** - Root user's home directory
- **`/etc`** - Configuration files
- **`/var/log`** - Log files (very important for DevOps!)
- **`/tmp`** - Temporary files

### Additional Directories (Good to Know)
- **`/bin`** - Essential command binaries
- **`/usr/bin`** - User command binaries
- **`/opt`** - Optional/third-party applications

---

## Part 2: Scenario-Based Practice

### Understanding How to Approach Scenarios

**Example Scenario: Check if a service is running**

**Question:** How do you check if the nginx service is running?

1. **Check service status:**
```bash
   systemctl status nginx
```
   **Why this command?** To see if service is active, failed, or stopped.

2. **If service is not found, list all services:**
```bash
   systemctl list-units --type=service
```
   **Why this command?** To see what services exist on the system.

3. **Check if service is enabled on boot:**
```bash
   systemctl is-enabled nginx
```
   **Why this command?** To know if it will start automatically after reboot.

**What I learned:** Always check status first, then investigate based on what you see.

---

### Scenario 1: Service Not Starting

**Problem:** A web application service called 'myapp' failed to start after a server reboot. What commands would you run to diagnose the issue?

**Solution:**

1. ```bash
   systemctl status myapp
```
   **Why:** Check if active, failed, or stopped

2. ```bash
   journalctl -u myapp -n 50
```
   **Why:** Read recent logs to find error messages

3. ```bash
   systemctl is-enabled myapp
```
   **Why:** Verify if it starts on boot

4. ```bash
   systemctl list-units --type=service
```
   **Why:** Confirm service exists and is recognized

---

### Scenario 2: High CPU Usage

**Problem:** Your manager reports that the application server is slow. You SSH into the server. What commands would you run to identify which process is using high CPU?

**Solution:**

1. **Use a command that shows live CPU usage:**
```bash
   top
```

2. **Look for processes sorted by CPU percentage:**
```bash
   ps aux --sort=-%cpu | head -10
```

3. **Easier interactive monitoring:**
```bash
   htop
```

4. **Note the PID (Process ID) of the top process**

---

### Scenario 3: Finding Docker Service Logs

**Problem:** A developer asks: "Where are the logs for the 'docker' service?" The service is managed by systemd. What commands would you use?

**Solution:**

1. ```bash
   systemctl status docker
```
   **Why:** Confirm service state

2. ```bash
   journalctl -u docker -n 50
```
   **Why:** View last 50 log lines

3. ```bash
   journalctl -u docker -f 
   **Why:** Follow logs in real-time