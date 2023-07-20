input_str = """GET pypi.org /simple/foo
GET pypi.org /simple/bar
GET pypi.org /simple/baz
POST example.com /api/foo"""

host_dict = dict[str, set]()
params = set()
for line in input_str.split("\n"):
    parts = line.split()
    if len(parts) >= 3:
        package_name = parts[2].split("/")[2]
        host_dict.setdefault(parts[1], set()).add(package_name)

## for pypi
print("from pypi.org there are %s packages downloaded in this workflow: " % str(len(host_dict['pypi.org'])))
for package in host_dict['pypi.org']:
    print("- %s" % package)

print("")
# for all hosts but pypi
for host in [host for host in host_dict if host != 'pypi.org']:
    print("%s url hitting %s in this workflow" % (str(len(host_dict[host])), host))