#!/bin/sh
#echo $(
result=$(echo "`echo '\\\\timing \\\\\\\\ \\\\i' $1 | sudo -u postgres psql i2b2 2> /dev/null`")
echo -n "["
echo "$result" | grep "         " | sed -e 's/ //g' | tr -d "\n";
echo -n " rows] | "
echo $(echo "$result" | grep 'Time: [0-9,.]* ms' | sed -e 's/Time: //g' | sed -e 's/ ms/ + /g' | tr -d '\n' | sed -e 's/+ $//g' | sed -e 's/,/\./g') | bc
