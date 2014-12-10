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

echo "Running Benchmark Queries... "
{
    for f in *.sql
    do
        echo -e "Running Query \e[1m$f\e[0m"
        progress &
        progPid=$!
        echo -e "Duration: \e[33m\e[1m" $(~/Utils-Queries/get_times.sh $f) "ms \e[0m"
        echo "" ; kill -13 "$progPid";
    done
}
