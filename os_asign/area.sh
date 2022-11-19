#!/bin/bash

#make a variable for the constant
constant=2.54;

#which values they want to enter first
read -p "What unit do you want to enter in. 1 = cm 2 = inch: " enter_unit


#enter the value of the length and width
read -p "Enter a length: " length
read -p "Enter a width: " width
area=$[$length*$width]

#if they want to convert the values of leave it the same
read -p "What unit do you want your answer to be in 1 = cm 2 = inch: " final_unit


#shows the area in inch if they press 2 on the final_unit and enter_unit
if [ "$final_unit" == 2 -a "$enter_unit" == "2" ] 
then 
    echo "The final area is $area inch"


#shows the area in cm if they press 1 on the final_unit and enter_unit
elif [ "$final_unit" == 1 -a "$enter_unit" == "1" ] 
then 
    echo "The final area is $area cm"


#shows the final area that is converted from inch to cm
elif [ "$final_unit" == 1 -a "$enter_unit" == "2" ] 
then 
    INCHTOCM=$(echo "scale=3; $area/$constant" | bc)
    echo "The final area is $INCHTOCM cm"


#shows the final area that is converted from cm to inch
elif [ "$final_unit" == 2 -a "$enter_unit" == "1" ] 
then 
    CMTOINCH=$(echo "scale=3; $area*$constant" | bc)
    echo "The final area is $CMTOINCH inch"

fi


read -p "end" end
