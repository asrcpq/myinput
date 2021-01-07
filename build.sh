stage1() {
	MOZC_DIR="$HOME/git/google/mozc/src/data/"
	cat $MOZC_DIR/dictionary_oss/dictionary*.txt | cut -d'	' -f1,5 > dict.out.txt
	python3 stage1_sk.py "$MOZC_DIR/single_kanji/single_kanji.tsv" >> dict.out.txt
}

stage2() {
	python3 stage2.py | awk '!x[$0]++' > stage2.out.txt
	cat map.txt >> stage2.out.txt
}

stage1
stage2
