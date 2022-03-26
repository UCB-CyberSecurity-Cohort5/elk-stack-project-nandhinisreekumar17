#!/bin/bash

if [ "${3,,}" == 'blackjack' ]
then
    awk -F" " '{print $1, $2, $3, $4}' $1_Dealer_schedule | grep "$2"
elif [ ${3,,} == 'roulette' ]
then
    awk -F" " '{print $1, $2, $5, $6}' $1_Dealer_schedule | grep "$2"
elif [ ${3,,} == 'texas_hold_em' ]
then
    awk -F" " '{print $1, $2, $7, $8}' $1_Dealer_schedule | grep "$2"
else
    echo "Invalid game name. Possible options are BlackJack, Roulette, Texas_Hold_Em"
fi


