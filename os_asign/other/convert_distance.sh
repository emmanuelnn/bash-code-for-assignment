#!/bin/bash

constant=2.54;


read -p "what unit do you want to enter in. 1 = cm 2 = inch: " enter_unit

read -p "Enter a length: " length
read -p "Enter a width: " width
area=$[$length*$width]


read -p "what unit do you want your answer to be in 1 = cm 2 = inch: " final_unit


if [ "$final_unit" == 2 -a "$enter_unit" == "2" ] 
then 
    echo "the final are is $area inch"

elif [ "$final_unit" == 1 -a "$enter_unit" == "1" ] 
then 
    echo "the final are is $area cm"

elif [ "$final_unit" == 1 -a "$enter_unit" == "2" ] 
then 
    INCH_CM="$(($area / $constant))"
    echo "the final are is $INCH_CM cm"

elif [ "$final_unit" == 2 -a "$enter_unit" == "1" ] 
then 
	ans=$(($final_unit * $enter_unit))


#$ echo "$((5 * 5))"
	#INCH_CM=awk "BEGIN {print $area * $constant}"
	#INCH_CM=printf %.10f\\n "$(($area * $constant))e-9"
	#python -c "print($area * $constant)"
   #INCH_CM="$(($area * $constant))"
    #INCH_CM=$(echo "scale=4; $area*$constant" | bc)
    echo "the final are is $INCH_CM inch"

fi