#!/bin/bash

progress() {
  pc=0;
  while true
    do
      echo -n -e "[$pc sec]\033[0K\r"
      sleep 1
      ((pc++))
    done
}

clear;


cd Benchmark-Queries
for f in Level-*.sql
do
    echo "Running $f"
    for i in `seq 1 10`;
    do
        progress &
        progPid=$!
        echo -e "Duration: \e[33m\e[1m" $(../helpers/get_times.sh $f) "ms \e[0m"
        kill -13 "$progPid";
    done
done
