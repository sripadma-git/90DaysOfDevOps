# Assign script arguments to variables
source_dir=$1
backup_dir=$2

# Generate a timestamp for the backup file (format: YYYY-MM-DD-HH-MM-SS)
timestamp=$(date '+%Y-%m-%d-%H-%M-%S')

# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory does not exist."
    exit 1
fi


# Function to display usage instructions
display_usage(){
    echo "Usage: ./backup.sh <source dir> <backup dir>"
}

# Display usage and exit if no arguments are provided
if [ $# -eq 0 ]; then
    display_usage
    exit 1
fi


# Function to create a backup
backup(){
    # Create a compressed tar.gz archive of the source directory in the backup directory
    tar -czf "${backup_dir}/backup_${timestamp}.tar.gz" "${source_dir}" > /dev/null

    # Check if tar command succeeded
    if [ $? -eq 0 ]; then
        echo "Backup created successfully: backup_${timestamp}"
        # List all backups in the backup directory with their sizes
        du -h "$backup_dir"*.tar.gz
    else
        echo "Backup failed"
        exit 1
    fi
}

# Call the backup function
backup


# Function to delete old backups (>14 days)

delete_old_backups(){
    # old backups deleted
    echo "Deleting old backups:"

    # Find and remove .tar.gz files older than 14 days in the backup directory
    find "$backup_dir" -name "*.tar.gz" -type f -mtime +14 -print -exec rm -f {} \;
    
}

# Call the cleanup function
delete_old_backups