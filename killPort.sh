#!/bin/bash
port=$1
if [ ! -n "${port}" ]; then
    echo "input port is null, please input like: $0 3306"
else
    #pid=$(netstat -ntlp|grep "$port"|awk 'NR==1{print $NF}')
    pid=$(lsof -i:"${port}"|awk 'NR==2{print $2}')
    name=$(lsof -i:"${port}"|awk 'NR==2{print $1}')
    if [ -z "${pid}" ]; then
        echo "The process for this port does not exist!"
        exit
    else
        read -p "Do you real want to kill ${name} ?[y/n]" flag
        if [ "${flag}" == y ]; then
            kill "${pid}"
            echo "${name} killed"
        else
            echo "Operation canceled!"
            exit
        fi
    fi
fi
