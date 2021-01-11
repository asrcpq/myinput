import sys
for line in sys.stdin:
	line_sp = line.split()
	for i in range(1, len(line_sp)):
		print(line_sp[i], line_sp[0])
