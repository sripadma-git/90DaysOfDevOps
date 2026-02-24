#!/bin/bash

# Store the first argument as the log directory
LOG_DIR="$1"

# Exit with an error if the directory doesn't exist
if [ ! -d "$LOG_DIR" ]; then
    echo "Directory doesn't exist: $LOG_DIR"
    exit 1
fi

# Compress .log files older than 7 days and count them
compressed=$(find "$LOG_DIR" -type f -name "*.log" -mtime +7 -exec gzip {} \; -print | wc -l)


# Delete .gz files older than 30 days and count them
deleted=$(find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -delete -print | wc -l)


# Prints how many files were compressed and deleted
echo "Compressed $compressed files."
echo "Deleted $deleted files."