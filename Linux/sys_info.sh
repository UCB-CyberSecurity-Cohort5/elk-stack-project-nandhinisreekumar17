#!/bin/bash
echo "A Quick System Audit Script"
date 
echo " " 
echo -e "Uname info: $(uname -a) \n"
echo -e "IP Info: $(ip addr | head -9 |tail -1) \n"
echo "Hostname: $(hostname -s)" 
