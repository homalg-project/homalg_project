#!/usr/bin/python3

import os
from pathlib import Path

cpu_times = {}
real_times = {}
for filename in Path(".").glob("**/performance.out"):
	package_name = os.path.basename(os.path.dirname(filename))
	print("read performance data for package", package_name)
	with open(filename) as file:
		cpu_time = file.readline()
		parts = cpu_time.split(" ")
		if len(parts) != 2:
			print(filename, "does not contain exactly two floats in the first line")
			continue
		total_cpu_time = round(float(parts[0]) + float(parts[1]), 2)
		cpu_times[package_name] = total_cpu_time
		real_time = file.readline()
		real_times[package_name] = float(real_time)

for key,value in cpu_times.items():
	with open(key + "_cpu_time.csv", "w") as file:
		file.write(key + "\n" + str(value))

for key,value in real_times.items():
	with open(key + "_real_time.csv", "w") as file:
		file.write(key + "\n" + str(value))
