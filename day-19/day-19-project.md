
# 📌 Day 19 – Log Rotation, Backup & Scheduled Maintenance

## 🔹 1. Log Rotation Script (log_rotate.sh)

### Features
- Compress `.log` files older than 7 days
- Delete `.gz` files older than 30 days
- Validates directory existence
- Displays number of compressed and deleted files

### Usage
```bash
chmod +x log_rotate.sh
./log_rotate.sh /path/to/log_directory
### 

2.Server Backup Script (backup.sh)
Features

Creates timestamped .tar.gz archive
Verifies backup creation
Displays archive size
Deletes backups older than 14 days
Handles invalid source directories

chmod +x backup.sh
./backup.sh /source_directory /backup_destination


3. Maintenance Script (maintenance.sh)
Features

Calls log rotation and backup scripts
Logs all output with timestamps
Redirects errors using 2>&1
Designed for cron scheduling

Cron Scheduling Examples: 

Run log rotation daily at 2 AM:
0 2 * * * /home/user/log_rotate.sh /home/user/test_logs

Run backup every Sunday at 3 AM:
0 3 * * 0 /home/user/backup.sh /home/user/data /home/user/backups

Run maintenance daily at 1 AM:
0 1 * * * /home/user/maintenance.sh