#!/usr/bin/env bash

function add_to_array() {
	case $1 in
		*[!0-9]*) exit 1 ;;
		*) ;;
	esac
	array+=( $1 )

	if [ $1 -gt $MAX ]; then
		MAX=$1
	fi
	if [ $1 -lt $MIN ]; then
		MIN=$1
	fi
}

if [ -t 0 ] && [ $# -lt 2 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]
then
	cat <<-EOF
		Spark

		Code was written by Joursoir <chat@joursoir.net>
		This is free and unencumbered software released into the public domain.

		Synopsis: spark [-h|--help] [number] ...
		EOF
	exit 0
fi

case `uname -m` in
	x86_64|amd64) # 64 bit
		MAX=$(( -2**63 ));
		MIN=$(( 2**63-1 )) ;; 
	i686|i386|x86) # 32 bit
		MAX=$(( -2**31 ));
		MIN=$(( 2**31-1 )) ;;
	*) # 16 bit
		MAX=$(( -2*15 ));
		MIN=$(( 2*15-1 )) ;;
esac

if [ $# -gt 1 ]
then
	for i in "$@"; do
		add_to_array $i
	done
else
	while read -r i; do
		add_to_array $i
	done
fi

LEVELS=8
DIFF=$(( $MAX - $MIN + 1 ))

for i in "${array[@]}"
do
	H=$(( 1 + ($i - $MIN + 1) * ($LEVELS-1) / $DIFF ))

	printf "\u258$H"
done

echo
exit 0