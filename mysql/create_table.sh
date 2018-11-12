#!/bin/bash
# send data to the the table in the MYSQL database

MYSQL=`which mysql`

if [ $# -ne 2 ]
then
	echo "Usage:mtest2 emplid lastname firstname salary"
else
	$MYSQL  -uroot -ppassword <<EOF
CREATE DATABASE DB1;
USE DB1;
CREATE TABLE `user`
{
userID int(11) not null,
userName varchar(20) not null,
userPass varchar(20) not null,
age int(10) not null,
primary key(userID)
};
EOF
	if [ $? -eq 0 ]
	then
		echo Data successfully added
	else
		echo Problem adding data
	fi
fi
