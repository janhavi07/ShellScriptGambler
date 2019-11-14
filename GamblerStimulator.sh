#!/bin/bash -x

echo WELCOME TO GAMBLER STIMULATOR

#VARIABLES
stake=100
bet=1

winlost=$(( RANDOM%2 ))
echo "HE BETS 1$"
if [ $winlost -eq 1 ]
then
	echo WIN
	stake=$(( $stake + $bet ))
else
	echo LOST
	stake=$(( $stake - $bet ))
fi
echo "STAKE IS :" $stake
