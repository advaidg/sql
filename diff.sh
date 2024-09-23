#!/bin/bash

# Step 1: Remove the `transactionNumber` field from anywhere in the first JSON file
jq 'walk(if type == "object" then del(.transactionNumber) else . end)' input.json | jq --sort-keys . > modified_input.json

# Step 2: Remove the `transactionNumber` field from anywhere in the second JSON file
jq 'walk(if type == "object" then del(.transactionNumber) else . end)' other_file.json | jq --sort-keys . > sorted_other_file.json

# Step 3: Compare the cleaned and sorted JSON files
diff modified_input.json sorted_other_file.json

# Step 4: Check the result of the diff command
if [ $? -eq 0 ]; then
    echo "The JSON files are identical after removing transactionNumber."
else
    echo "The JSON files have differences."
fi
