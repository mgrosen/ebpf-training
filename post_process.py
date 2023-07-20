import sys
from py_markdown_table.markdown_table import markdown_table

host_dict = dict()
params = set()

file_path = sys.argv[1]

with open(file_path, 'r') as file:
    lines = file.readlines()[3:]
    for line in lines:
        parts = line.split()
        if len(parts) >= 3:
            url = parts[2]
            host_dict.setdefault(parts[1], set()).add(url)

table_data = []

for host in host_dict:
    table_data += [(str(len(host_dict[host])), host)]

sorted_data = sorted(table_data, key=lambda x: int(x[0]), reverse=True)
markdown_ready_data = [{"Host": str(entry[1]), "Count": int(entry[0])} for entry in sorted_data]
markdown = markdown_table(markdown_ready_data).set_params(padding_weight = 'right').get_markdown()

print('# Proccessed eBPF sniffed HTTPS traffic')
print('')
print("## Host query counts ")
print('')
print(markdown)
print('')
## python packages
print("## %s Python packages downloaded in this workflow" % len(host_dict['pypi.org']))
sorted_python_packages = sorted(host_dict['pypi.org'], key=lambda x: x.split("/")[2])
for url in sorted_python_packages:
    print("- %s" % url.split("/")[2])