#!/bin/bash -x

echo WELCOME TO GAMBLER STIMULATOR

#VARIABLES
STAKE=100
BET=1
RESIGNVALUE=50
NOOFDAYS=30
stakeI=0
totalAmount=0
win=0
lose=0
amount=0

declare -A winLost
winningStake=$(( ($RESIGNVALUE*$STAKE)/100  + $STAKE ))
losingStake=$(( $STAKE - ($RESIGNVALUE*$STAKE)/100 ))

for(( day=1; day<=$NOOFDAYS; day++ ))
{
	stakeI=$STAKE
	while [ $stakeI -lt $winningStake  ] && [ $stakeI -gt $losingStake ]
	do
		winlost=$(( RANDOM%2 ))
		echo "HE BETS 1$"
		if [ $winlost -eq 1 ]
		then
			echo WIN
			stakeI=$(( $stakeI + $BET ))
		else
			echo LOST
			stakeI=$(( $stakeI - $BET ))
		fi

	done
	 winLost[$day]=$(( $stakeI - $STAKE ))
         totalAmount=$(( totalAmount + $(( $stakeI - $STAKE )) ))


}
for k in "${winLost[@]}"
do
	amount=$(( $amount + $k ))
done
if [ $amount -lt 0 ]
then
	echo "Lost by : " $amount
else
	echo "Won by : " $amount
fi
