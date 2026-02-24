#!/bin/bash

# ===============================
# Day 20 - Log Analyzer Script
# ===============================

# ---------- Task 1: Input Validation ----------

if [ $# -eq 0 ]; then
    echo "Usage: $0 <log_file_path>"
    exit 1
fi

LOG_FILE=$1

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# ---------- Basic Info ----------

DATE=$(date +%Y-%m-%d)
REPORT_FILE="log_report_${DATE}.txt"
TOTAL_LINES=$(wc -l < "$LOG_FILE")

# ---------- Task 2: Error Count ----------

ERROR_COUNT=$(grep -Ei "ERROR|Failed" "$LOG_FILE" | wc -l)

echo "Total Errors: $ERROR_COUNT"

# ---------- Task 3: Critical Events ----------

CRITICAL_EVENTS=$(grep -n "CRITICAL" "$LOG_FILE")

echo "------ Critical Events ------"

if [ -z "$CRITICAL_EVENTS" ]; then
    echo "No critical events found."
else
    echo "$CRITICAL_EVENTS" | while IFS= read -r line
    do
        LINE_NUMBER=$(echo "$line" | cut -d: -f1)
        MESSAGE=$(echo "$line" | cut -d: -f2-)
        echo "Line $LINE_NUMBER: $MESSAGE"
    done
fi

# ---------- Task 4: Top 5 Error Messages ----------

TOP_ERRORS=$(grep "ERROR" "$LOG_FILE" \
    | awk -F'ERROR ' '{print $2}' \
    | sort \
    | uniq -c \
    | sort -nr \
    | head -5)

echo ""
echo "------ Top 5 Error Messages ------"
echo "$TOP_ERRORS"

# ---------- Task 5: Generate Report ----------

{
echo "========== Log Analysis Report =========="
echo "Date of Analysis: $DATE"
echo "Log File: $LOG_FILE"
echo "Total Lines Processed: $TOTAL_LINES"
echo "Total Error Count (ERROR + Failed): $ERROR_COUNT"
echo ""
echo "------ Top 5 Error Messages ------"
echo "$TOP_ERRORS"
echo ""
echo "------ Critical Events ------"
if [ -z "$CRITICAL_EVENTS" ]; then
    echo "No critical events found."
else
    echo "$CRITICAL_EVENTS"
fi
echo "========================================="
} > "$REPORT_FILE"

echo ""
echo "Report generated: $REPORT_FILE"

# ---------- Task 6 (Optional): Archive Log ----------

mkdir -p archive
mv "$LOG_FILE" archive/

echo "Log file moved to archive/"