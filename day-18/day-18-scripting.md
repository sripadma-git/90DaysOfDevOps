# Day 18 – Shell Scripting: Functions & Intermediate Concepts.

# Task 1: Basic Functions
functions.sh :
```
#!/bin/bash

greet() {
    echo "Hello, $1!"
}

add() {
    sum=$(( $1 + $2 ))
    echo "Sum: $sum"
}

greet "Padma"
add 10 20
```
---

# Task 2: Functions with System Checks.
disk_check.sh

```
#!/bin/bash

check_disk() {
    echo "Disk Usage:"
    df -h /
}

check_memory() {
    echo "Memory Usage:"
    free -h
}

main() {
    check_disk
    echo
    check_memory
}

main
```
---

# Task 3: Strict Mode — set -euo pipefail
strict_demo.sh 
```
#!/bin/bash
set -euo pipefail

echo "Testing strict mode..."

# Uncomment one at a time to test behavior

# Undefined variable (set -u)
# echo "$UNDEFINED_VAR"

# Failing command (set -e)
# false

# Pipeline failure (set -o pipefail)
# grep "text" nonexistentfile | wc -l

echo "Script completed."
```
---

# Task 4: Local Variables
```
#!/bin/bash

use_local() {
    local message="I am local"
    echo "$message"
}

use_global() {
    message="I am global"
}

use_local
echo "Outside function (local test): ${message:-Not Defined}"

use_global
echo "Outside function (global test): $message"

```
---

# Task 5: Build Script – System Info Reporter.

```
#!/bin/bash
set -euo pipefail

print_header() {
    echo "=============================="
    echo "$1"
    echo "=============================="
}

system_info() {
    print_header "System Information"
    echo "Hostname: $(hostname)"
    echo "OS: $(uname -a)"
}

uptime_info() {
    print_header "Uptime"
    uptime
}

disk_usage() {
    print_header "Top 5 Disk Usage"
    du -h / 2>/dev/null | sort -hr | head -5
}

memory_usage() {
    print_header "Memory Usage"
    free -h
}

top_cpu() {
    print_header "Top 5 CPU Processes"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
}

main() {
    system_info
    uptime_info
    disk_usage
    memory_usage
    top_cpu
}

main
```