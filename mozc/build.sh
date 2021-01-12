set -e

stage0() {
	cd $(dirname "$0")
	if ! [ -d ./mozc ]; then
		mkdir mozc
		curl https://raw.githubusercontent.com/google/mozc/master/src/data/dictionary_oss/dictionary0{0..9}.txt > mozc/dictionary.out.txt
		curl https://raw.githubusercontent.com/google/mozc/master/src/data/single_kanji/single_kanji.tsv > mozc/single_kanji.out.txt
	fi
}

stage1() {
	cat ./mozc/dictionary.out.txt | cut -d'	' -f1,5 > dict.out.txt
	python3 stage1_sk.py "./mozc/single_kanji.out.txt" >> dict.out.txt
}

stage2() {
	python3 stage2.py | awk '!x[$0]++' > ../dicts/mozc.out.txt
	cat map.txt | sed 's/^/H/g' >> ../dicts/mozc.out.txt
}

stage0
stage1
stage2
