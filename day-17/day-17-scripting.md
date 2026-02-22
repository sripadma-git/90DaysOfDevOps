Day 17 – Shell Scripting: Loops, Arguments & Error Handling.

Task 1: For Loop:

for_loop.sh :
```
#!/bin/bash

fruits=("Apple" "Banana" "Mango" "Orange" "Grapes")

for fruit in "${fruits[@]}"
do
    echo "Fruit: $fruit"
done
```

count.sh:
```
#!/bin/bash

for i in {1..10}
do
    echo $i
done

```

Task 2: While Loop
countdown.sh:
```
#!/bin/bash

read -p "Enter a number: " num

while [ $num -ge 0 ]
do
    echo $num
    ((num--))
done

echo "Done!"
```

Task 3: Command-Line Arguments:

greet.sh:

```
#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./greet.sh <name>"
    exit 1
fi

echo "Hello, $1!"

args_demo.sh:
#!/bin/bash

echo "Script name: $0"
echo "Total arguments: $#"
echo "All arguments: $@"

Task 4: Install Packages via Script.
install_packages.sh:
#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root."
    exit 1
fi

packages=("nginx" "curl" "wget")

for pkg in "${packages[@]}"
do
    if dpkg -s "$pkg" &> /dev/null; then
        echo "$pkg is already installed. Skipping."
    else
        echo "$pkg is not installed. Installing..."
        apt update -y
        apt install -y "$pkg"
        echo "$pkg installation complete."
    fi
done
```

Task 5: Error Handling
safe_script.sh:
``` 
#!/bin/bash

set -e

mkdir /tmp/devops-test || echo "Directory already exists"

cd /tmp/devops-test || { echo "Failed to enter directory"; exit 1; }

touch test-file.txt || echo "Failed to create file"

echo "All operations completed successfully."
```