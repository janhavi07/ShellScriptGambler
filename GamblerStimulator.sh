#!/bin/bash -x

echo WELCOME TO GAMBLER STIMULATOR

#VARIABLES
stake=100
BET=1
RESIGNVALUE=50

winningStake=$(( ($RESIGNVALUE*$stake)/100  + $stake ))
losingStake=$(( $stake - ($RESIGNVALUE*$stake)/100 ))

while [ $stake -lt $winningStake  ] && [ $stake -gt $losingStake ]
do
	winlost=$(( RANDOM%2 ))
	echo "HE BETS 1$"
	if [ $winlost -eq 1 ]
	then
		echo WIN
		stake=$(( $stake + $BET ))
	else
		echo LOST
		stake=$(( $stake - $BET ))
	fi
	winningStake=$(( (50*$stake)/100 +$stake ))
        losingStake=$(( $stake - (50*$stake)/100 ))

done
echo "RESIGNS FOR THE DAY"

