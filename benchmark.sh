echo "Running Benchmark Queries... "
{
    cd Utils-Queries/
    for f in *.sql
    do
        echo -e "Running Query \e[1m$f\e[0m"
        progress &
        progPid=$!
        echo -e "Duration: \e[33m\e[1m" $(~/Utils-Queries/get_times.sh $f) "ms \e[0m"
        echo "" ; kill -13 "$progPid";
    done
}