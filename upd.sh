#!/bin/bash

fileName=$1

# Array of extensions
extensions=("CTRL" "ACCOUNTS" "TRANS" "BALANCE" "PAIRDATA" "BILLING")

# Loop to create files with different extensions
for ext in "${extensions[@]}"; do
    touch "${fileName}.${ext}"
done

# Create a separate file with .CORP extension if the file name starts with "US" or "CZ"
if [[ $fileName == US* || $fileName == CZ* ]]; then
    touch "${fileName}.CORP"
fi

echo "Files created successfully."
