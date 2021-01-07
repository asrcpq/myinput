import sys
skfile = open(sys.argv[1]);
for line in skfile:
	line_sp = line.split()
	for ch in line_sp[1]:
		print(line_sp[0], ch)
skfile.close()
