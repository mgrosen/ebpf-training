import sys

file_path = sys.argv[1]

data = []

with open(file_path, 'r') as file:
    for line in file:
        fields = line.strip().split()
        if len(fields) >= 14:
            comm = fields[0].split("=")[1]
            dst = fields[9].split("=")[1]
            dns_name = fields[12].split("=")[1]
            data.append({"COMM": comm, "DST": dst, "DNS_NAME": dns_name})

# Filter out duplicate entries based on DST
filtered_data = []
dst_set = set()
for entry in data:
    if entry["DST"] not in dst_set:
        filtered_data.append(entry)
        dst_set.add(entry["DST"])

print("# Processed eBPF sniffed DNS DATA")

for entry in filtered_data:
    print(f"- COMM: {entry['COMM']}, DST: {entry['DST']}, DNS_NAME: {entry['DNS_NAME']}")
