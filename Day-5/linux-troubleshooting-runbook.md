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
