Day 11 – File ownership challenge (chown & chgrp) 

Task 1: Understanding Ownership  

Run ls –l in your home directory. 

Identify the owner and group columns. 

Check who owns your files.  

Format: -rw-r- - r- -1 owner group size date filename. 

 

Difference Between Owner and Group : 

Owner – The user who owns the file. Has primary control. 

Group – A collection of users. Members inherit group-level permissions.  

 

Task 2: Basic chown Operations 

Create file: touch devops-file.txt 

Check owner: ls -l devops-file.txt => -rw-r--r-- 1 ubuntu ubuntu devops-file.txt 

Change owner to Tokyo:  sudo chown tokyo devops-file.txt 

Verify: ls -l devops-file.txt 

 

Change owner to berlin : sudo chown berlin devops-file.txt  (Verify again) 

Task 3: Basic chgrp Operations 

Create file: touch team-notes.txt 

Check group: ls -l team-notes.txt 

Create group: sudo groupadd heist-team 

Change group: sudo chgrp heist-team team-notes.txt (Verify: ls -l team-notes.txt) 

Group column should now show: heist-team 

 

Task 4: Combined Owner & Group Change. 

1.Create file: touch project-config.yaml 

2. Change both owner & group: sudo chown professor:heist-team project-config.yaml (Verify it) 

3. Create directory: mkdir app-logs 

4. Change ownership: sudo chown berlin:heist-team app-logs (Verify: ls -ld app-logs) 

Task 5: Recursive Ownership 

1. Create directory structure :  

mkdir -p heist-project/vault 

mkdir -p heist-project/plans 

touch heist-project/vault/gold.txt 

touch heist-project/plans/strategy.conf 

2. Create group: sudo groupadd planners 

3. Change ownership recursively: sudo chown -R professor:planners heist-project/ 

(Verify: ls -lR heist-project/ )  

Task 6: Practice Challenge 

Create users:  

 sudo useradd -m tokyo 

sudo useradd -m berlin 

sudo useradd -m nairobi 

2. Create groups: sudo groupadd vault-team 

Sudo groupadd tech-team 

              3. Create directory: mkdir bank-heist  

Set ownership: 

1. access-code.txt: sudo chown tokyo:vault-team bank-heist/access-codes.txt 

2. blueprints.pdf: sudo chown berlin:tech-team bank-heist/blueprints.pdf 

3. escape-plan.txt : sudo chown nairobi:vault-team bank-heist/escape-plan.txt Verify : ls -l bank-heist/