# Linux Internals – DevOps Foundation

This document covers the core Linux concepts required for troubleshooting and system management in production environments.

---

## 1️⃣ Core Components of Linux

### Kernel
- The core component of the operating system.
- Manages CPU, memory, devices, and system calls.
- Acts as an interface between hardware and user applications.

### User Space
- Environment where users and applications operate.
- Includes shells, command-line tools, and system utilities.
- Communicates with the kernel via system calls.

### Init / systemd
- First process started by the kernel (PID 1).
- Responsible for initializing the system.
- Manages background services and system processes.

---

## 2️⃣ Process Creation & Management

- Every running program is a **process**.
- A process is created using `fork()`.
- The new program is loaded using `exec()`.
- Each process is assigned a unique **PID (Process ID)**.
- Parent processes create child processes.

### Common Process States

| State | Meaning |
|-------|---------|
| R     | Running (actively using CPU) |
| S     | Sleeping (waiting for resource) |
| T     | Stopped (manually paused) |
| Z     | Zombie (finished but not cleaned up) |

### Why Process States Matter

Understanding process behavior helps in diagnosing:
- High CPU usage
- Memory leaks
- Stuck or unresponsive applications
- Zombie/orphan processes

---

## 3️⃣ systemd – Service Management

`systemd` is the modern init system used in most Linux distributions.

### Responsibilities:
- Starts services during system boot
- Automatically restarts failed services
- Manages service dependencies
- Collects logs through `journald`

### Importance for DevOps

- Faster debugging of crashed services
- Improved service reliability
- Clear visibility into logs and service status
- Reduced incident resolution time

---

## 4️⃣ Essential Daily Commands

| Command      | Purpose |
|--------------|----------|
| `ps`         | View running processes |
| `top`        | Monitor CPU & memory usage |
| `systemctl`  | Manage system services |
| `journalctl` | View system logs |
| `kill`       | Terminate processes |

---

## 📌 Conclusion

Linux is the base operating system for most production systems.  
Understanding kernel behavior, process lifecycle, and systemd service management forms the foundation for effective DevOps troubleshooting and incident response.
