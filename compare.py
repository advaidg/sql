import json
import argparse

# Function to remove 'transactionNumber' recursively
def remove_transaction_number(obj):
    if isinstance(obj, dict):
        obj.pop('transactionNumber', None)
        for key in obj:
            remove_transaction_number(obj[key])
    elif isinstance(obj, list):
        for item in obj:
            remove_transaction_number(item)

# Function to compare two JSON objects
def compare_json(json1, json2):
    return json1 == json2

# Set up argument parsing
parser = argparse.ArgumentParser(description="Remove 'transactionNumber' and compare two JSON files.")
parser.add_argument('file1', type=str, help='First JSON file path')
parser.add_argument('file2', type=str, help='Second JSON file path')

# Parse the command-line arguments
args = parser.parse_args()

# Step 1: Load and clean the first JSON file (removing 'transactionNumber')
with open(args.file1, 'r') as f:
    data1 = json.load(f)

remove_transaction_number(data1)

# Step 2: Load and clean the second JSON file
with open(args.file2, 'r') as f:
    data2 = json.load(f)

remove_transaction_number(data2)

# Step 3: Compare the two cleaned JSON objects
if compare_json(data1, data2):
    print("The JSON files are identical after removing 'transactionNumber'.")
else:
    print("The JSON files have differences.")

# Optional: You can save the cleaned JSON
