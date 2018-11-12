#!/usr/bin/env bash

export ProgName=`basename $0`
cd `dirname $0`
export CurrDir=`pwd`
cd - > /dev/null 2>&1

export PATH=$PATH:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:./
export PHP=/usr/bin/php
export SCRIPT_ROOT=/www/test.php

#########################################
#Add these lines to prevent re-entrance
#########################################
function RunningCheck
{
	local LockFile="$CurrDir/.$ProgName.lock"
	if [ -f "$LockFile" ]; then
		local LastPID=`cat $LockFile`
		if [ `ps --cols=250 $LastPID | grep "$ProgName" | wc -l ` -gt 0 ]; then
			exit
		fi
	fi

	echo $$ > $LockFile
}

function LongRunForGodXMPP
{
        while [ 1 ]
        do
                ${PHP} ${SCRIPT_ROOT}
        done
}

function main
{
	RunningCheck

	LongRunForGodXMPP
}

main $*

