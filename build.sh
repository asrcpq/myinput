stage1() {
	MOZC_DIR="$HOME/git/google/mozc/src/data/dictionary_oss"
	cat $MOZC_DIR/dictionary*.txt | cut -d'	' -f1,5 > dict.out.txt
}

stage2() {
	python3 stage2.py | awk '!x[$0]++' > stage2.out.txt
	cat map.txt >> stage2.out.txt
}

stage2
