Task 1: Create Users 

1 .Create three users with home directories and passwords:

tokyo
berlin
professor

=> sudo useradd -m tokyo
sudo useradd -m berlin
sudo useradd -m professor
 -m creates /home/username

2. Set Passwords :
sudo passwd tokyo
sudo passwd berlin
sudo passwd professor

3. verify users : 
cat /etc/passwd | grep -E "tokyo|berlin|professor"

check home directories : ls -l /home

Task 2 :  Create Groups :
sudo groupadd developers
sudo groupadd admins

verify : cat /etc/group | grep -E "developers|admins"

Task 3: Assign users to groups 
- add users to groups :
sudo usermod -aG developers tokyo
sudo usermod -aG developers berlin
sudo usermod -aG admins berlin
sudo usermod -aG admins professor

- aG : append to group

Task 4 :  Shared Directory.
1.Create Directory - sudo mkdir /opt/dev-project

2.Change Group Owner: sudo chgrp developers /opt/dev-project

3.Set permissions : sudo chmod 775 /opt/dev-project.
verify : ls -ld /opt/dev-project

4.Test File Creation :
Test as tokoyo : sudo -u tokyo touch /opt/dev-project/tokyo-file.txt
Test as berlin : sudo -u berlin touch /opt/dev-project/berlin-file.txt
verify : ls -l /opt/dev-project

Task 5 : Team Workspace
1. Create User : sudo useradd -m nairobi
sudo passwd nairobi

2. Create Group : sudo groupadd project-team

3. Add users to Group : 
sudo usermod -aG project-team nairobi
sudo usermod -aG project-team tokyo

verify : 
groups nairobi
groups tokyo

4.Create Workspace Directory :
sudo mkdir /opt/team-workspace
sudo chgrp project-team /opt/team-workspace
sudo chmod 775 /opt/team-workspace

5.Test as nairobi :
sudo -u nairobi touch /opt/team-workspace/test.txt
verify : ls -l /opt/team-workspace
