#!/bin/bash

# Step 1: Remove `transactionNumber` from anywhere in the first JSON and sort keys recursively
jq 'walk(if type == "object" then del(.transactionNumber) else . end) | jq --sort-keys .' input.json > modified_input.json

# Step 2: Remove `transactionNumber` from anywhere in the second JSON and sort keys recursively
jq 'walk(if type == "object" then del(.transactionNumber) else . end) | jq --sort-keys .' other_file.json > sorted_other_file.json

# Step 3: Compare the cleaned and sorted JSON files
diff modified_input.json sorted_other_file.json

# Step 4: Check the result of the diff command
if [ $? -eq 0 ]; then
    echo "The JSON files are identical after removing `transactionNumber` and sorting recursively."
else
    echo "The JSON files have differences."
fi
