#!/bin/bash

for f in Level-*.sql
do
    for i in `seq 1 10`;
    do  
        echo -e "Duration: \e[33m\e[1m" $(./get_times.sh $f) "ms \e[0m"
    done
done
