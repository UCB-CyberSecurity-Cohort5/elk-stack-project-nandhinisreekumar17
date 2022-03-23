#!/bin/bash
if [ -f ~/research/sys_info.txt ]
then
	echo "File exists"
	rm -rf ~/research/sys_info.txt
else
	echo "File does not exist"
fi
