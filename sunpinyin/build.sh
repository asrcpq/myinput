set -e

stage0() {
	cd $(dirname "$0")
	if ! [ -f dict.out.txt ]; then
		curl -sL https://raw.githubusercontent.com/sunpinyin/open-gram/master/data/dict.full > dict.out.txt
	fi
	if ! [ -f comm.out.txt ]; then
		curl -sL "https://raw.githubusercontent.com/DavidSheh/CommonChineseCharacter/master/3500%E5%B8%B8%E7%94%A8%E5%AD%97.txt" > comm.out.txt
	fi
	pv dict.out.txt |\
		egrep "^[$(cat comm.out.txt | sed -E 's/(.)/\1|/g' | sed 's/1.*//g' | sed -E 's/^.(.*).$/\1/g')]* " |\
		sed 's/:[^%]*%//g' |\
		python3 split_duoyinzi.py > dict_split.out.txt
}

stage1() {
	cat dict.out.txt | grep -o '[a-z]*' | sort -u > map.out.txt
	sed -E -i 's/^zh(.*)/V\1 zh\1/g' ./map.out.txt
	sed -E -i 's/^ch(.*)/I\1 ch\1/g' ./map.out.txt
	sed -E -i 's/^sh(.*)/U\1 sh\1/g' ./map.out.txt
	sed -E -i 's/^([bpmfdtnlgkhjqxrzcsywaeiou])(.*)/\U\1\L\2 \1\2/g' ./map.out.txt
	# longest first!
	sed -i 's/uang /D /g' ./map.out.txt
	sed -i 's/iang /D /g' ./map.out.txt
	sed -i 's/iong /S /g' ./map.out.txt
	sed -i 's/uan /R /g' ./map.out.txt
	sed -i 's/uai /Y /g' ./map.out.txt
	sed -i 's/ang /H /g' ./map.out.txt
	sed -i 's/eng /G /g' ./map.out.txt
	sed -i 's/ing /Y /g' ./map.out.txt
	sed -i 's/ian /M /g' ./map.out.txt
	sed -i 's/iao /C /g' ./map.out.txt
	sed -i 's/ong /S /g' ./map.out.txt
	sed -i 's/ua /W /g' ./map.out.txt
	sed -i 's/un /P /g' ./map.out.txt
	sed -i 's/uo /O /g' ./map.out.txt
	sed -i 's/an /J /g' ./map.out.txt
	sed -i 's/ao /K /g' ./map.out.txt
	sed -i 's/ai /L /g' ./map.out.txt
	sed -i 's/ia /W /g' ./map.out.txt
	sed -i 's/ei /Z /g' ./map.out.txt
	sed -i 's/ie /X /g' ./map.out.txt
	sed -i 's/ue /T /g' ./map.out.txt
	sed -i 's/ve /T /g' ./map.out.txt
	sed -i 's/ui /V /g' ./map.out.txt
	sed -i 's/iu /Q /g' ./map.out.txt
	sed -i 's/en /F /g' ./map.out.txt
	sed -i 's/in /N /g' ./map.out.txt
	sed -i 's/ou /B /g' ./map.out.txt
	sed -E -i 's/(.*)/\L\1/g' ./map.out.txt
	if (cat map.out.txt | awk '{print $2}' | sort | uniq -c | grep -v ' 1 '); then
		echo "key conflict!"
		exit 1
	fi
}

stage2() {
	python3 stage2.py > ../dicts/sunpinyin.out.txt
}

stage0
stage1
stage2
