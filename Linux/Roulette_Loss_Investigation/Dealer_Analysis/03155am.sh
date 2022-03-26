#!/bin/bash
awk -F" " '{print $1, $2, $5, $6}' 0315_Dealer_schedule | grep -i "05:00:00 AM" 

