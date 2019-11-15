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

function gamblerLogic()
{
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
winLose
}

function winLose()
{
for k in "${winLost[@]}"
do
	amount=$(( $amount + $k ))
done
if [ $amount -lt 0 ]
then
	echo "You Lost by : " $amount
	echo "BYE BYE "
else
	echo "You Won by : " $amount
	read -p "Do you want to continue? Type 1 for YES and O for NO." yesNo
	if [ $yesNo -eq 1 ]
	then
		gamblerLogic


	else
		echo "BYE BYE"
	fi
fi
}

gamblerLogic




