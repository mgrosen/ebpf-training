import sys
import re

python_hosted_regex = r"/packages/.*/(.*?)-\d+\..*"

host_dict = dict()
params = set()

file_path = sys.argv[1]

with open(file_path, 'r') as file:
    for line in file:
        parts = line.split()
        if len(parts) >= 3:
            url = parts[2]
            host_dict.setdefault(parts[1], set()).add(url)

for host in [host for host in host_dict if host != 'pypi.org']:
    print("%s url hitting %s in this workflow" % (str(len(host_dict[host])), host))

print("")

## python packages
print("from pypi.org there are %s packages downloaded in this workflow: " % str(len(host_dict['pypi.org']) + len(host_dict['files.pythonhosted.org'])))
for url in host_dict['pypi.org']:
    print("- %s" % url.split("/")[2])
for url in host_dict['files.pythonhosted.org']:
    match = re.search(python_hosted_regex, url)
    if match:
        print("- %s" % match.group(1))