set -e

stage0() {
	cd $(dirname "$0")
	mkdir -p dicts
	if ! [ -d ./mozc ]; then
		git clone --depth=1 https://github.com/google/mozc
	fi
	curl -sL https://raw.githubusercontent.com/sunpinyin/open-gram/master/data/dict.full | \
		tr -d "'" | \
		awk '{print $2, $1}' > dicts/sunpinyin.out.txt
}

stage1() {
	MOZC_DIR="./mozc/src/data/"
	cat $MOZC_DIR/dictionary_oss/dictionary*.txt | cut -d'	' -f1,5 > dict.out.txt
	python3 stage1_sk.py "$MOZC_DIR/single_kanji/single_kanji.tsv" >> dict.out.txt
}

stage2() {
	python3 stage2.py | awk '!x[$0]++' > dicts/mozc.out.txt
	cat map.txt >> dicts/mozc.out.txt
}

stage0
# stage1
# stage2
