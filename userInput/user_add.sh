#!/usr/bin/env bash

USERS_INFO=./user_data.txt
USERADD=/usr/sbin/useradd
PASSWD=/usr/bin/passwd
CUT=/bin/cut

while read LINES; do
    USERNAME=`echo $LINES | cut -f1 -d ' '`
    PASSWORD=`echo $LINES | cut -f2 -d ' '`
    $USERADD $USERNAME
    if  [ $? -ne 0 ]; then
        echo "$USERNAME exists,skip set password"
    else
        echo $PASSWORD | $PASSWD --stdin $USERNAME
    fi
done < user_data.txt