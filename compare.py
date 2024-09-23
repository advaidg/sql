import json
from deepdiff import DeepDiff
import argparse

def remove_transaction_number(obj):
    if isinstance(obj, dict):
        obj.pop('transactionNumber', None)
        for key in obj:
            remove_transaction_number(obj[key])
    elif isinstance(obj, list):
        for item in obj:
            remove_transaction_number(item)

parser = argparse.ArgumentParser(description="Remove 'transactionNumber' and compare two JSON files.")
parser.add_argument('file1', type=str, help='First JSON file path')
parser.add_argument('file2', type=str, help='Second JSON file path')

args = parser.parse_args()

with open(args.file1, 'r') as f:
    data1 = json.load(f)

remove_transaction_number(data1)

with open('output1.json', 'w') as f:
    json.dump(data1, f, indent=2)

with open(args.file2, 'r') as f:
    data2 = json.load(f)

remove_transaction_number(data2)

with open('output2.json', 'w') as f:
    json.dump(data2, f, indent=2)

diff = DeepDiff(data1, data2, ignore_order=True)

if not diff:
    print("The JSON files are identical after removing 'transactionNumber'.")
else:
    print("The JSON files have differences:")
    print(diff)
