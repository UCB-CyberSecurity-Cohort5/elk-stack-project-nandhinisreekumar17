#!/bin/bash
awk -F" " '{print $1, $2, $5, $6}' 0312_Dealer_schedule | grep -i "11:00:00 PM" 

