#!/bin/bash 

echo WELCOME TO GAMBLER STIMULATOR

#VARIABLES
STAKE=100
BET=1
RESIGNVALUE=50
NOOFDAYS=20
stakeI=0
totalAmount=0
win=0
lose=0
amount=0
temperory=0  #to store count of Lucky Unlucky days
unluck=0
temp=0
#Dictionary
declare -A winLost
declare -A luckyUnlucky
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
	 #temperory=$(( $temperory + (( $stakeI - $STAKE )) ))
         totalAmount=$(( totalAmount + $(( $stakeI - $STAKE )) ))
	 luckyUnlucky[$day]=$totalAmount 


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

for k in "${!luckyUnlucky[@]}" #Printing them by sorting by amount
do
        echo $k ${luckyUnlucky["$k"]}
done |
sort -n -k2 


echo "Unluckyday****"
for k in "${!luckyUnlucky[@]}"
do

        echo $k ${luckyUnlucky["$k"]}
done |
sort -n -k2 | head -n 1 # for printing Unlucky day

echo "LuckyDay*******"
for k in "${!luckyUnlucky[@]}"
do
	echo Luckyday amount
        echo $k ${luckyUnlucky["$k"]}
done |
sort -n -k2 | tail -1 #fro printing the Luckiest Day










 

