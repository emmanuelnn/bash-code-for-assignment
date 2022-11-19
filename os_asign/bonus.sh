#!/bin/bash
> mkdir salesperson

#calculate month
function input
{

#enter the month
echo "enter the month(e.g. 04) ="
read month
echo " momth = $month"
if [ $month -gt 12 ] ||test $month -lt 1
then
echo "wrong value  $month, try again"; exit 1
fi

#enter the salesperson
echo "enter the salesperson"
read salesperson
printf "\n"

#enter the sale amount
echo "sale amount for this month"
read sales

#enter the filename
echo "enter the file mame "
read FileName


}
input



#calculate bonus
function bonus
{

if [ $sales -lt 200000 ]
then
                bonus=0
                echo "bonus= $bonus"
elif [ $sales -ge 200000 ] &&  test $sales -lt 300000
then
             bonus=1000
             echo "bonus= $bonus"
else
if [ $sales -ge 300000 ] && test $sales -lt 400000
 then
 bonus=1500
echo "bonus= $bonus"
 else
                        if [ $sales -ge 400000 ] && test $sales -lt 500000
                        then
                        bonus=2500
                        echo "bonus= $bonus"
                        else
 if [ $sales -ge 500000 ] && test $sales -lt 650000
 then
 bonus=3000
echo "bonus= $bonus"
 else
 echo " over salling $sales"
 fi
                        fi
                fi                      
fi
}
bonus


#calculate the salary after tax
bonus=-1000
function taxCal
{
 Basic_salary=2000  
 Basic_Rate_lower=$(expr 12501 / 12) ; Basic_Rate_upper=$(expr 50000 / 12)
 High_Rate_lower=$(expr 12501 / 12) ; High_Rate_upper=$(expr 150000 / 12)   
 
 Total_monthly_salary=$((Basic_salary + bonus)) 

 if [ $Total_monthly_salary -lt $Basic_Rate_lower ]
 then
  Tax=0
  Salary_after_tax=$((Total_monthly_salary - Tax))
 else
     if [ $Total_monthly_salary -le $Basic_Rate_upper ]
     then
      Tax=$(expr $Basic_Rate_upper / 20)
      
      Salary_after_tax=$((Total_monthly_salary - Tax))
      echo "Total salary after Tax = $Salary_after_tax"
      else
      test $Total_monthly_salary -gt $High_Rate_lower
      Tax=$(expr $Basic_Rate_high / 40)
      Salary_after_tax=$((Total_monthly_salary - Tax))
      echo "Total salary after Tax = $Salary_after_tax"
      
      fi
fi
    
}
taxCal


#check the correct input model 

function model
{
printf "if the sale is A class enter 1\nif the sale is B class enter 2\nif the sale is C class enter 3\nif the sale is E class enter 4\nif the sale is AMGC65  enter 5\n model="
read model
if [ $model -lt  1 ] || test $model -gt 5
then
echo 'Data entry is wrong, try again to enter the correct model' ; checkMod=1

else
        checkMod=0 ; 
               case $model in
		1) MM=A_class ; echo "You enter Model = $MM";;
		2) MM=B_class ; echo "You enter Model = $MM";;
		3) MM=C_class ; echo "You enter Model = $MM";;
		4) MM=E_class ; echo "You enter Model = $MM";;
		5) MM=AMGC65_class ; echo "You enter Model = $MM";;
	    esac
fi

while [ $checkMod -eq 1 ]
do
        echo "Run the program again and enter the correct Model"
break
done

}
 model



#To write the results into file 
echo "The sales for month ($month) in 2021 is £$sales, and $salesperson has paid £$Salary_after_tax" >> $FileName.txt

read -p "end" end
