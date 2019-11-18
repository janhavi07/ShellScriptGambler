#!/bin/bash -x 

echo "******WELCOME TO GAMBLER STIMULATOR*******"

#VARIABLES
declare STAKE=100
declare BETAMOUNT=1
declare RESIGNVALUE=50
declare NOOFDAYSPLAYED=20
declare initialStake=0
declare totalAmountWinLost=0
declare WIN=1
declare LOSE=0
declare addedAmountOfWinOrLost=0
declare WINNINGSTAKE=$(( ($RESIGNVALUE*$STAKE)/100  + $STAKE ))
declare LOSINGSTAKE=$(( $STAKE - ($RESIGNVALUE*$STAKE)/100 ))

#Dictionary
declare -A winLostChart
declare -A luckyUnluckyChart

function gamblingLogic()
{
for(( day=1; day<=$NOOFDAYSPLAYED; day++ ))
{
	initialStake=$STAKE
	while [ $initialStake -lt $WINNINGSTAKE  ] && [ $initialStake -gt $LOSINGSTAKE ]
	do
		isThisWinLost=$(( RANDOM%2 ))
		echo "HE BETS 1$"
		if [ $isThisWinLost -eq $WIN ]
		then
			echo WIN
			initialStake=$(( $initialStake + $BETAMOUNT ))
		else [ $isThisWinLost -eq $LOSE ]
			echo LOST
			initialStake=$(( $initialStake - $BETAMOUNT ))
		fi

	 done
	 winLostChart[$day]=$(( $initialStake - $STAKE ))
         totalAmountWinLost=$(( $totalAmountWinLost + $(( $initialStake - $STAKE )) ))
	 luckyUnluckyChart[$day]=$totalAmountWinLost


}
didHeWinOrLose
}


function didHeWinOrLose()
{
	for column in "${winLostChart[@]}"
	do
		addedAmounOfWinOrLost=$(( $addedAmountOfWinOrLost + $column ))
	done
	if [ $addedAmountOfWinOrLost -lt 0 ]
	then
		echo "You Lost by : " $addedAmountOfWinOrLost
		echo "BYE BYE "
	else
		echo "You Won by : " $addedAmountOfWinOrLost
		read -p "Do you want to continue? Type 1 for YES and O for NO." wantToContinueOrNot
		if [ $wantToContinueOrNot -eq 1 ]
		then
			gamblingLogic

		else
			echo "BYE BYE"
		fi
	fi
}

function toFindOutUnluckyDay()
{
	for column in "${!luckyUnluckyChart[@]}"
	do
	   	echo $column ${luckyUnluckyChart["$column"]}
	done |
	sort -n -k2 | head -n 1 
}


function toFindOutLuckyDay()
{
	for column in "${!luckyUnluckyChart[@]}"
	do
        	echo $column ${luckyUnluckyChart["$column"]}
	done |
	sort -n -k2 | tail -1 
}

function main()
{
	gamblingLogic
	echo "UnluckyDay and Amount: "
	toFindOutUnluckyDay
	echo "LuckyDay and Amount :"
	toFindOutLuckyDay
}

echo "STARTING THE GAME "
main


