#!/bin/bash

#randomsuit=$(( ( $RANDOM % 4 ) + 1 ))
#randomnum=$(( ( $RANDOM % 52 ) + 1 ))
#echo "Random:"$randomnum

#The deck of cards
#key
#C = Clubs
#D = Diamonds
#H = Hearts 
#S = Spades

FreshDeck=('CAce' 'C2' 'C3' 'C4' 'C5' 'C6' 'C7' 'C8' 'C9' 'C10' 'CJack' 'CQueen' 'CKing' 
'DAce' 'D2' 'D3' 'D4' 'D5' 'D6' 'D7' 'D8' 'D9' 'D10' 'DJack' 'DQueen' 'DKing' 
'HAce' 'H2' 'H3' 'H4' 'H5' 'H6' 'H7' 'H8' 'H9' 'H10' 'HJack' 'HQueen' 'HKing' 
'SAce' 'S2' 'S3' 'S4' 'S5' 'S6' 'S7' 'S8' 'S9' 'S10' 'SJack' 'SQueen' 'SKing');

usercount=0
uservalue=0
playDeck=(${FreshDeck[@]})

#echo ${playDeck[@]}
#echo ${playDeck[1]}

#Test deck for removed cards
#playDeck=('0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' '0' 
#'0' '0' '0' '0' 'D5' '0' 'D7' '0' 'D9' '0' '0' '0' '0' 
#'0' '0' '0' 'H4' '0' '0' 'H7' '0' '0' '0' '0' '0' '0' 
#'0' '0' 'S3' '0' '0' '0' '0' '0' 'S9' 'S10' '0' '0' '0');

#+++++++++----------------------------------------------------------+++++++++++++++++++++++++++++++++
#+++++++++----------------------------------------------------------+++++++++++++++++++++++++++++++++
#Functions

#Function Skip Blank slots after card is dealt
SkipBlankCards () {
   while [[ $selected == 0 && $randomnum < 52 ]]
			do
				
				#--------------TEST BLOCK-------------------------------------
				#Dealing with removed cards works as long as rand num is not 52
				# If 52, adding 1+ to randnum goes above array size
				#Giving error
				#To fix, try for or while loop to cycle through existing playhand
				# if card at position = 0, move on till posi !=0
				#Loop should ensure staying in the array. 
				# Careful with infinite cycling through an empty deck
				# !!! PERHAPS LIMIT NUMBER OF PLAYS/ROUNDS TO AVOID INFITIE LOOP 
				# !!! PERHAPS PUT MARKER AT END OF ARRAY, if rand+1=marker, break

				#--------------TEST BLOCK-------------------------------------

				

				randomnum=$(( $randomnum + 1 ))
				selected=${playDeck[$randomnum]}
				#echo "loop"$selected
			done
}


#Function get value of Ace/King/Queen/Jack
SpecialCardValue () {
if [[ ($long = "King") || ($long = "Queen") || ($long = "Jack") ]]
		then
			uservalue=$(echo "$uservalue+10"|bc)
		
		elif [[ $long == "Ace" ]]
		then
			echo "Selected Ace, Choose 1 or 11"
			read ace
			#echo $ace
				if [[ $ace = '1' ]]
				then
					uservalue=$(echo "$uservalue+1"|bc)
				else
					uservalue=$(echo "$uservalue+11"|bc)
				fi
		
		else
			short=${selected:1:2}
			uservalue=$(echo "$uservalue+$short"|bc)
		fi
}

#Function to pick card
DealCard () {
	randomnum=$(( ( $RANDOM % 51 ) + 1 ))
	selected=${playDeck[$randomnum]}
	#echo "Random Number: "$randomnum
	
}

#DEALER'S HAND
dealercount=0
dealervalue=0

DealersHand () {
	DealCard
	if [[ $selected == '0' ]]
		then
			#Calling Function SkipBlank
			SkipBlankCards
	fi	
			
	dealerhand[$dealercount]=$selected
	playDeck[$randomnum]=0

	dealercount=$(echo "$dealercount+1"|bc)

		
	long=${selected:1:5}
		

	#Special Cards value
	if [[ ($long = "King") || ($long = "Queen") || ($long = "Jack") ]]
		then
			dealervalue=$(echo "$dealervalue+10"|bc)
		#Ace
		elif [[ $long == "Ace" ]]
		then
			#Dealer's Ace value choice
				if [[ $dealervalue < '6' ]]
				then
					dealervalue=$(echo "$dealervalue+1"|bc)
				else
					dealervalue=$(echo "$dealervalue+11"|bc)
				fi
		
		else
			short=${selected:1:2}
			dealervalue=$(echo "$dealervalue+$short"|bc)
		fi
}

#Function to Find Winner 
FindWinner () {
#displays if there is no winner 
	if [[ ($dealervalue > "21") && ($uservalue > "21") ]]
	then
		echo "BOTH BUST, NO WINNER"
#displays that the user won if the dealer cards bust		
	elif [[ ($dealervalue > "21") && ($uservalue < "22") ]]
	then
		echo "DEALER BUST, USER WINS"
#displays that the dealer won if the user cards bust
	elif [[ ($dealervalue < "22") && ($uservalue > "21") ]]
	then
		echo "USER BUST, DEALER WINS"
#displays that the game is a draw
	elif [[ ($dealervalue == "21") && ($uservalue == "21") || ($uservalue == $dealervalue) ]]
	then
		echo "DRAW"
#displays that the dealer won if they got the score 21 and the user hasn't
	elif [[ ($dealervalue == "21") && ($uservalue != "21") ]]
	then
		echo "DEALER WINS"
#displays that the user won if they got the score 21 and the dealer hasn't
	elif [[ ($dealervalue != "21") && ($uservalue == "21") ]]
	then
		echo "USER WINS"
#displays who won if they got a number that is closer to the score number of
	elif [[ ($dealervalue != "21") && ($uservalue != "21") && ($uservalue < "21") && ($uservalue < "21") ]]
	then
		if [[ $dealervalue > $uservalue ]]
		then
			echo "DEALER WINS"	
		elif [[ $dealervalue < $uservalue ]]
		then
			echo "USER WINS"
		fi
	else
		echo " "
		
	fi	
}
#+++++++++----------------------------------------------------------+++++++++++++++++++++++++++++++++
#+++++++++----------------------------------------------------------+++++++++++++++++++++++++++++++++
#MAIN BODY

#Running Dealer's Hand
DealersHand
DealersHand

if [[ $dealervalue < '10' ]]
then
	DealersHand
	DealersHand
elif [[ $dealervalue > "10" && $dealervalue < "17" ]]		
then
	DealersHand
fi	
# the the instructions with keys of the suits cards names
echo "#############################################"
echo " H- Hearts; S- Spades; D- Diamonds; C- Clubs "
echo " 1 to Deal, 2 to end Round"
echo "#############################################"

while [ "$deal" != 2 ]
do
		
	echo "Deal? 1-Yes 2-No"
	read deal
	if [[ $deal = 1 ]]
	then
		
		#USER CARDS
		
			#Deal Card function
			DealCard
		
			#echo "TESTPlaydeck current status"${playDeck[@]}

			
			if [[ $selected == '0' ]]
			then
				#Calling Function SkipBlank
				SkipBlankCards
			
			
			fi	
			
			disphand[$usercount]=$selected
			playDeck[$randomnum]=0
		
			usercount=$(echo "$usercount+1"|bc)

			echo "Picked: "$selected
		
			long=${selected:1:5}
		
			#TEST#long="Ace"

			#Function AceValue
			SpecialCardValue
		
			
			#echo "usercount:"$usercount
			echo "Value is "$uservalue
			

	fi	
	
# !!!While loop done
done
echo "Your Hand "${disphand[@]}
echo "Value is "$uservalue

echo " "
echo "Dealer Hand "${dealerhand[@]}
echo "Dealer Value "$dealervalue

echo " "
#Function to Find Winner Called
FindWinner


read -p "end" end
