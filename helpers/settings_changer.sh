#!/bin/bash

if [ $# -lt 2 ]
  then
    echo -e "\e[31mUsage: $0 FIELD VALUE\e[0m\nexample: \e[32m$0 shared_buffers 4GB\e[0m"; exit;
fi

SETTINGS_FILE="/etc/postgresql/9.3/main/postgresql.conf"

SET=$1
VALUE=$2

BACKUP="`grep "^$SET" $SETTINGS_FILE`"
sudo sed -i -e "s/^$SET.*$/$SET = $VALUE/g" $SETTINGS_FILE

cd..
./benchmark.sh

sudo sed -i -e "s/^$SET.*$/$BACKUP/g" $SETTINGS_FILE
