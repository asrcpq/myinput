import sys

mapfile = open("map.out.txt")
dictfile = open("dict_split.out.txt")

zrm = {}
for line in mapfile:
	line_sp = line.split()
	zrm[line_sp[1]] = line_sp[0]

for line in dictfile:
	[pin, zi] = line.split()
	for each in pin.split("'"):
		print(zrm[each], end = '')
	print(" " + zi)

mapfile.close()
dictfile.close()
