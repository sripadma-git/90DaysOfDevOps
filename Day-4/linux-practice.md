# Linux Practice – Process, Service & Log Commands

This note covers basic Linux process commands, systemd service commands, and log inspection. It also demonstrates what actually happens when a service is restarted.

---

## 1️ Process Commands

| Command | Simple Definition |
|----------|-------------------|
| `ps` | Displays currently running processes. |
| `top` | Shows real-time system resource usage and running processes. |
| `htop` | Interactive and improved version of `top`. |
| `pgrep <name>` | Finds the Process ID (PID) of a running process by name. |

---

## 2️ Service Commands (systemd)

| Command | Simple Definition |
|----------|-------------------|
| `systemctl status <service>` | Shows whether a service is running and displays its Main PID and logs. |
| `systemctl list-units --type=service` | Lists all active system services. |
| `sudo systemctl restart <service>` | Stops the service and starts it again. |

---

## 3️ Log Commands

| Command | Simple Definition |
|----------|-------------------|
| `journalctl -u <service>` | Displays logs for a specific service. |
| `tail -n 50 <file>` | Shows the last 50 lines of a log file. |
| `journalctl -f` | Shows logs in real time (live monitoring). |

---

while inspecting the SSH service, I realized that restarting a service doesn’t just refresh it , it actually kills the old Process ID (PID) and spawns a new one. Watching the PID change in real time made me understand what restart truly means at the process level.

 you can also explore this by entering :  (  command : systemctl status ssh now you can look for this line -  Main PID: 1234 (sshd) ) 

👉 Note down that PID number.

now lets Restart the service : sudo systemctl restart ssh ,  now this command stops the service, kills the current process , starts a new process.

 now lets check the PID again : use this command ( systemctl status ssh ) now you can see Main PID: 1458 (sshd)



The PID will be different.

