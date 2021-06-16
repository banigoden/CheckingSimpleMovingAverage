#!/bin/bash
filename="$1
#read all lines in the file
while read -a line; do
    array[$index]=$line 
    ((index++))
done < $filename
arrayOfSize=10
#Take parametrs and get the average 
for (( a = 0; $(( a + $arrayOfSize )) < ${#array[*]}; a++ ))
    do
    sumONInterval=0
    for (( b=a; b < $(($a + $arrayOfSize)); b++ ))
        do    
        ((sumONInterval+= ${array[b]}))          
     done
    average=$(($sumONInterval / $arrayOfSize))
    arrayOfAverage[$i]=$average
    ((i++))
done
# count trend
trend=0
for ((a=0; a < ${#arrayOfAverage[*]}-1; a++))
    do
    diff=$((${arrayOfAverage[$a+1]}-${arrayOfAverage[a]}))
    if [[ diff -gt 0 ]]
        then
        ((trend++))
    elif [[ diff -le 0  ]]
        then
        ((trend--))      
    fi
done
# output of trend
size=${#arrayOfAverage[*]}
trendNeutral=$(( $size / 2 ))
if  [[ trend -gt trendNeutral ]] ; then
    echo "Trend up"
elif [[ trend -lt $(( trendNeutral*-1 )) ]] ; then
    echo "Trend down"
else
    echo "Trend neutral"
fi
"