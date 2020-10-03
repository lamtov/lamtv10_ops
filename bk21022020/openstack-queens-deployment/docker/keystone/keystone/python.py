import re


with open("nova-compute.log") as origin_file:
    for line in origin_file:
        line = re.findall(r'instance: a84519d0-b15a-4afa-bfb1-4a9cd7b913b8.*', line)
        if line:
           line = line[0].split('"')[1]
        print line