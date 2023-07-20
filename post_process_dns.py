import sys
from py_markdown_table.markdown_table import markdown_table

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

# Generate the markdown table
table_data = [{"COMM": entry["COMM"], "DST": entry["DST"], "DNS_NAME": entry["DNS_NAME"]} for entry in filtered_data]
markdown = markdown_table(table_data).set_params(padding_weight='right', row_sep='markdown', quote=False).get_markdown()

print("# Processed eBPF sniffed DNS")
print("")
print(markdown)
