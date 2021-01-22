#!/usr/bin/env bash

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

for i in "$@"
do
	case $i in
		''|*[!0-9]*) exit 1 ;;
		*) ;;
	esac

	if [ $i -gt $MAX ]; then
		MAX=$i
	fi
	if [ $i -lt $MIN ]; then
		MIN=$i
	fi
done

LEVELS=8
DIFF=$(( $MAX - $MIN + 1 ))

for i in "$@"
do
	H=$(( 1 + ($i - $MIN + 1) * ($LEVELS-1) / $DIFF ))

	printf "\u258$H"
done

echo