import json

# Load the JSON file
with open('input.json', 'r') as f:
    data = json.load(f)

# Function to remove 'transactionNumber' recursively
def remove_transaction_number(obj):
    if isinstance(obj, dict):
        # Remove 'transactionNumber' from dictionaries
        obj.pop('transactionNumber', None)
        for key in obj:
            remove_transaction_number(obj[key])
    elif isinstance(obj, list):
        # Iterate over list items
        for item in obj:
            remove_transaction_number(item)

# Remove 'transactionNumber' from the JSON structure
remove_transaction_number(data)

# Write the result to an output file
with open('output.json', 'w') as f:
    json.dump(data, f, indent=2)

print("transactionNumber removed successfully!")
