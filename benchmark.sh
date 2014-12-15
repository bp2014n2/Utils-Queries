#!/bin/bash

LOG_FILE=../logs/log.txt

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

echo "saving log to $LOG_FILE"
cd Benchmark-Queries
for f in Level-*.sql
do
    sudo service postgresql restart;
    echo "Running $f" | tee -a $LOG_FILE
    for i in `seq 1 5`;
    do
        progress &
        progPid=$!
        echo -e "Duration: \e[33m\e[1m" $(../helpers/get_times.sh $f) "ms \e[0m" | tee -a $LOG_FILE
        kill -13 "$progPid";
    done
done
