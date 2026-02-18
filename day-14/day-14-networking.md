Day 14 – Networking Fundamentals & Hands-on Checks Task.

Quick Concepts: 
# OSI Model :
1.L1 Physical – Cables, signals, NIC hardware

2. L2 Data Link – MAC address, switching

3. L3 Network – IP addressing & routing

4. L4 Transport – TCP/UDP, ports

5. L5 Session – Session management

6. L6 Presentation – Encryption/formatting

7. L7 Application – HTTP, DNS, FTP

# TCP/IP Stack

Link → Combines OSI L1 + L2

Internet → IP routing (OSI L3)

Transport → TCP/UDP (OSI L4)

Application → HTTP, HTTPS, DNS (OSI L5–L7)

Hands-On Checklist (Run & Record)
1. identity : hostname -I
2. Reachability : ping -c 4 google.com
3. Path Check: traceroute google.com
4. Open Ports on Your Machine : ss -tulpn
5. Name resolution: nslookup <domain>
6.HTTP check: curl -I <http/https-url>
7.Connections snapshot: netstat -an | head

# Mini Task: Port Probe & interpret 
1. Suppose SSH is listening on 22. Test : curl -I http://localhost:3000
