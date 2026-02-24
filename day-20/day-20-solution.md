# Day 20 – Bash Scripting Challenge  
## Log Analyzer and Report Generator

## 📌 Objective

Automate the process of analyzing server log files and generating a daily summary report.

---

## 🔹 Features Implemented

### 1. Input Validation
- Accepts log file path as argument
- Exits if no argument provided
- Exits if file does not exist

### 2. Error Count
- Counts lines containing `ERROR` or `Failed`

### 3. Critical Events Detection
- Extracts lines containing `CRITICAL`
- Displays line numbers

### 4. Top 5 Error Messages
- Extracts message portion after `ERROR`
- Counts occurrences
- Sorts in descending order
- Displays top 5

### 5. Summary Report Generation
Creates:log_report_<date>.txt


Includes:
- Date of analysis
- Log file name
- Total lines processed
- Total error count
- Top 5 error messages
- Critical events

### 6. Archive Feature
- Creates `archive/` directory
- Moves processed log file into archive

---

## 🛠 Tools Used

- grep (-Ei, -n)
- awk
- sort
- uniq -c
- head
- wc -l
- date
- mkdir
- mv

---

## ▶ Usage

```bash
chmod +x log_analyzer.sh
./log_analyzer.sh sample_log.log