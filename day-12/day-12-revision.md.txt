# Day 12 – Breather & Revision:  

Mindset & Plan Review: revisit your Day 01 learning plan—are your goals still right?

Processes & Services Review: 

1.Check running processes:  ps aux | head 

2.Check service status: systemctl status ssh 

3.Check service logs: journalctl -u ssh --since "10 minutes ago" 

File Skills Quick Practice: 

1.Append content: echo "Revision entry" >> notes.txt 

2.Change permission: chmod 640 notes.txt 

3.Change ownership:  sudo chown tokyo:vault-team notes.txt (verify it)  

Cheat Sheet Refresh – Top 5 Incident Commands 

1. ps aux , 2. systemctl status <service > , 3. journactl –xe , 4. df –h , 5. ls –l  

User / Group Sanity Practice : 

Scenario Recreated: sudo useradd -m testuser , sudo groupadd testgroup , sudo chown testuser:testgroup notes.txt 

Verification: id testuser , ls -l notes.txt 

Mini Self-Check :  

Which 3 commands save you the most time? 

-> Systemctl status , ls –l , ps aux => These diagnose 80% of issues quickly. 

How do you check if a service is healthy? 

-> systemctl status <service> 

-> journalctl -u <service> -n 20 

-> ss -tuln | grep <port> 

How do you safely change ownership & permissions?  

_> sudo chown user:group file.txt 

-> chmod 640 file.txt 

What will you focus on improving in the next 3 days?
Over the next 3 days, I will focus on faster debugging of services using systemctl and journalctl, improving confidence with LVM and filesystem management, and reinforcing permission control (chmod, chown, groups) through repeated hands-on practice.