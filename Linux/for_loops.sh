#!/bin/bash
states=('California' 'Texas' 'Hawaii' 'Oregon' 'Vermont')
for state in ${states[@]}
do
if [ $state == "Hawaii" ]
then	
	echo "Hawaii is the best"
else
	echo "I am not fond of Hawaii"
fi
done

