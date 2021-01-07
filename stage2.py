import sys
# ignore kanji len > 4
MAXLEN = 4

mapfile = open("map.txt")
dictfile = open("dict.out.txt")
mapdict = {}
revdict = {}
ttflag = False
for line in mapfile:
	line_sp = line.split()
	mapdict[line_sp[1]] = line_sp[0]
	revdict[line_sp[0]] = line_sp[1]
for line in dictfile:
	line_sp = line.split()
	if len(line_sp[1]) > MAXLEN:
		continue
	mappedstr = ""
	for ch in line_sp[0]:
		if ch == revdict['tt']:
			ttflag = True
			continue
		else:
			ttflag = False
		if (ch == revdict['xya'] or \
			ch == revdict['xyu'] or \
			ch == revdict['xyo']) and \
			len(mappedstr) >= 2:
			mappedstr = mappedstr[:-1] + mapdict[ch][1:]
		elif ttflag and mapdict[ch][0] not in 'aeiou':
			mappedstr += mapdict[ch][0] + mapdict[ch]
		else:
			try:
				mappedstr += mapdict[ch]
			except:
				mappedstr += "?"
	print(mappedstr, line_sp[1])
mapfile.close()
dictfile.close()
