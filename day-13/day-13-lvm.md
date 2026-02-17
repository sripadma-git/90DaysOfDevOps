# Day 13 – Linux Volume Management (LVM)

This project demonstrates hands-on practice with Linux Volume Management (LVM) using an AWS EC2 instance and multiple EBS volumes.

---

##  Setup

- Created an EC2 instance
- Attached 3 EBS volumes:
  - 10GB
  - 12GB
  - 14GB
- Volumes attached as:
  - /dev/sdf
  - /dev/sdg
  - /dev/sdh

---

## Task 1: Check Current Storage

Run:

lsblk
sudo pvs
sudo vgs
sudo lvs
df -h

---

##  Task 2: Create Physical Volumes

Switch to root:

sudo su

Check physical volumes (initially none):

pvs

Create physical volumes:

pvcreate /dev/nvme1n1 /dev/nvme2n1 /dev/nvme3n1

Verify:

pvs

---

## Task 3: Create Volume Group

Create volume group using two disks:

vgcreate tws_vg /dev/nvme1n1 /dev/nvme2n1

Verify:

vgs

---

## Task 4: Create Logical Volume

lvcreate -L 500MB -n tws_lv tws_vg

Verify: lvs

---

## Task 5: Format and Mount

Create mount directory:

mkdir /mnt/tws_lv_mount

Format logical volume:

mkfs.ext4 /dev/tws_vg/tws_lv

Mount volume:

mount /dev/tws_vg/tws_lv /mnt/tws_lv_mount

Verify:
df -h
lsblk

---

##  Task 6: Extend Logical Volume

Extend volume by 200MB:

lvextend -L +200M /dev/tws_vg/tws_lv

Check updated size:
df -h
lsblk

---

