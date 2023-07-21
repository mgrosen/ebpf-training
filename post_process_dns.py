import sys
from py_markdown_table.markdown_table import markdown_table

host_dict = dict()

file_path = sys.argv[1]

with open(file_path, 'r') as file:
    lines = file.readlines()[3:]
    for line in lines:
        parts = line.split()
        if len(parts) >= 14:
            comm = parts[0].split("=")[1]
            proto = parts[4].split("=")[1]
            src = parts[5].split("=")[1]
            dst = parts[6].split("=")[1]
            dns_name = parts[12].split("=")[1]
            dns_data = ""
            for part in parts[14:]:
                if part.startswith("DNS_DATA="):
                    dns_data = part.split("=")[1]
                    break
            host_dict.setdefault(comm, []).append((proto, src, dst, dns_name, dns_data))

markdown_data = []
for comm, entries in host_dict.items():
    for entry in entries:
        proto, src, dst, dns_name, dns_data = entry
        markdown_data.append({"COMM": comm, "PROTO": proto, "SRC": src, "DST": dst, "DNS_NAME": dns_name, "DNS_DATA": dns_data})

if len(markdown_data) > 0:
    sorted_data = sorted(markdown_data, key=lambda x: x["COMM"])
    markdown = markdown_table(sorted_data).set_params(padding_weight='right', row_sep='markdown', quote=False).get_markdown()

    print('# Processed eBPF sniffed HTTPS traffic')
    print('')
    print("## DNS Queries")
    print('')
    print(markdown)
else:
    print("No valid data found in the input file.")
