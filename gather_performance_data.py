#!/usr/bin/python3

import os
from pathlib import Path

times = {}
for filename in Path(".").glob("*/performance.out"):
	package_name = os.path.dirname(filename)
	print("read performance data for package", package_name)
	with open(filename) as file:
		content = file.read()
		parts = content.split(" ")
		if len(parts) != 2:
			print(filename, "does not contain exactly two floats")
			continue
		total_time = round(float(parts[0]) + float(parts[1]), 2)
		times[package_name] = total_time

headers = []
values = []
for key in sorted(times.keys()):
	headers.append('"' + key + '"')
	values.append('"' + str(times[key]) + '"')

with open("performance_data.csv", "w") as file:
	file.write(",".join(headers) + "\n" + ",".join(values))
