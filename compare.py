import json
from deepdiff import DeepDiff

# Load both JSON files
with open('output.json', 'r') as f1, open('other_file.json', 'r') as f2:
    json1 = json.load(f1)
    json2 = json.load(f2)

# Compare the two JSON objects
diff = DeepDiff(json1, json2, ignore_order=True)

# Check if there is any difference
if not diff:
    print("The JSON files are identical.")
else:
    print("The JSON files have differences:")
    print(diff)
