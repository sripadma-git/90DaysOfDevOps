Day 10 – File Permissions & File Operations Challenge.

Task 1: Create Files
1. Create empty files devops.txt using touch.'
2. create notes.txt with some content using cat or echo.
3.Create script.sh using vim with content: echo "Hello DevOps"

verify: ls -l to see permissions. 

Task 2: Read Files. 
1.Read notes.txt using cat: cat notes.txt 
2.View script.sh in vim read-only mode: vim -R script.sh 
3.Display first 5 lines of /etc/passwd: head -n 5 /etc/passwd 
4.Display last 5 lines:tail -n 5 /etc/passwd. 

Task 3: Understand Permissions 
Format: rwxrwxrwx(owner-group-others) 
R = read (4), W=write (2), X=execute (1) 
Check your files: ls –l devops.txt notes.txt script.sh 

Task 4: Modify Permissions  
Make script.sh executable: chmod +x script.sh and verify ls –l script.sh 
Make devops.txt read-only: chmod a-w devops.txt and verify ls –l devops.txt 
Set notes.txt to 640: chmod 640 notes.txt and verify: ls –l notes.txt 
Create project directory with 755: mkdir project, chmod 755 project. 

Task 5: Test Permissions  
Try Writing to Read-Only File: echo "test" >> devops.txt 
Try Executing Without Execute Permission:  
Remove execute: chmod -x script.sh 
Try running:  ./script.sh 
Output: Permission denied. 
Reason: Execute bit is required to run scripts. 