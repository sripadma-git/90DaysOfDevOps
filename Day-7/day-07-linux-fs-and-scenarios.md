## Day 7/90 – Linux File System Hierarchy & Scenario-Based Practice. 


Today's goal is to understand where things live in Linux and practice troubleshooting like a DevOps engineer. 

 
Part 1: Linux File System Hierarchy. 

Document the purpose of these essential directories: 

Core Directories (Must Know): 

/ (root) - The starting point of everything 

/home - User home directories 

/root - Root user's home directory 

/etc - Configuration files 

/var/log - Log files (very important for DevOps!) 

/tmp - Temporary files 

Additional Directories (Good to Know): 

/bin - Essential command binaries 

/usr/bin - User command binaries 

/opt - Optional/third-party applications. 

 

----
 ## Part  2: Scenario-Based Practice. 

Solved scenario: understanding how to approach scenarios. 

Example scenario : Check if a service is running. 

Question: How do you check if the nginx service is running ? 

1. Check service status : systemctl status nginx 

Why this command? To see what service is active, failed, or stopped. 

 

2 If service is not found, list all service : systemctl list-units –type=service  

Why this command? To see what service exist on the system. 

   3.  check if service is enabled on boot : systemctl is-enabled nginx. 

 Why this command? To know if it will start automatically after reboot 
 
 What i learned: Always check status first, then investigate based on what you see. 

----

# Scenario 1: Service Not starting. 

A web application service called 'myapp' failed to start after a server reboot.What commands would you run to diagnose the issue?Write at least 4 commands      in order. 

 
1.systemctl status myapp (Why: Check if active, failed,or stopped) 

2. journalctl –u myapp –n 50 (Why : Read recent logs to find error messages) 

3. systemctl is-enabled myapp (Why: Verify if it starts on boot.) 

4. systemctl list-units –type=service (Why: Confirm service exists and is recognized) 

 

----

# Scenario 2 : High CPU Usage. 

Your manager reports that the application server is slow.You SSH into the server. What commands would you run to identify ?which process is using high CPU? 

Use a command tat shows live CPU usage : top . 

Look for processes sorted by CPU percentage : ps aux –sort=-%cpu | head –10 

Easier interactive monitoring : htop. 

Note the PID(process ID ) of the top process. 

----

# Scenario 3 : Finding Docker service Logs. 

A developer asks: "Where are the logs for the 'docker' service?"The service is managed by systemd.What commands would you use? 

 1. systemctl status docker (why : confirm service state) 

 2. journalctl –u docker –n 50 (why : view last 50 log lines) 
 
3.journalctl -u docker –f : (why: follow logs in real-time )   

----

# Scenario 4 : Permission Denied Script  

A script at /home/user/backup.sh is not executing.When you run it: ./backup.sh 

You get: "Permission denied" ? What commands would you use to fix this? 

1.   Check current permissions :  ls  –l  /home/user/backup.sh ( Look for –rw-r--r—notice no 'x’ = not executable. 

2. check for execute permission. chmod +x /home/user/backup.sh :  

3.  verify it worked : ls  –l  /home/user/backup.sh (Look for : -rwx-xr-x ) 

4.   Try running it :  ./backup.sh 
