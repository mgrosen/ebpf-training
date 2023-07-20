input_str = """GET pypi.org /simple/foo
GET pypi.org /simple/bar
GET pypi.org /simple/baz"""

host_dict = dict[str, set]()
params = set()
for line in input_str.split("\n"):
    parts = line.split()
    if len(parts) >= 3:
        package_name = parts[2].split("/")[2]
        host_dict.setdefault(parts[1], set()).add(package_name)

for host in host_dict:
    print("from " + host + " there are " + str(len(host_dict[host])) + " packages: ")
    print(host_dict[host])