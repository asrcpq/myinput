import sys
mapfile = open("map.txt")
dictfile = open("dict.out.txt")
mapdict = {}
for line in mapfile:
	line_sp = line.split()
	mapdict[line_sp[1]] = line_sp[0]
for line in dictfile:
	line_sp = line.split()
	mappedstr = ""
	for ch in line_sp[0]:
		try:
			mappedstr += mapdict[ch]
		except:
			mappedstr += "?"
	print(mappedstr, line_sp[1])
mapfile.close()
dictfile.close()
