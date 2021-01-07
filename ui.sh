#!/bin/zsh
set -e
cd "${0:A:h}"
BUFFER=""
while true; do
	read -r -s -k 1 c
	if [ "$c" = "." ]; then
		echo -ne $BUFFER | xsel -i -b
		exit
	elif [ "$c" = "," ]; then
		BUFFER=${BUFFER%?}
	elif [ "$c" = "" ]; then
		exit
	else
		BUFFER+="$(cat stage2.out.txt | fzf --query=$c | cut -d' ' -f2 )"
	fi
	echo "$BUFFER"
done
