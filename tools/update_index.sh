#!/usr/bin/env bash

# Program
#     This program is used to update sphinx indexer by unix time difference.
# History
#     2017/04/13

cd `dirname $0`
export CurrDir=`pwd`
cd - > /dev/null 2>&1
export ProgName=`basename $0`

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# memcached connect address
MCCMD="nc 127.0.0.1 11211"
# sphinx indexer address
INDEXER_PATH="/opt/sphinx/bin/indexer"
# trigger time (second)
MAX_TIME_INTERVAL=60
# sleep time (second)
MAX_SLEEP_SECOND=5
# memcached indexer key
SPHINX_INDEXER_KEY=sphinx_indexer_update_time

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

function rebuildSphinxIndexes
{
    #$INDEXER_PATH --all --rotate > /dev/null 2>&1 &
    $INDEXER_PATH --all --rotate
}

while [[ 1 ]]; do
	#check sphinx indexer process
	IndexCount=`ps -ef |grep "$INDEXER_PATH" | grep -v grep|wc -l`
	if [[ $IndexCount -le 0 ]];then
		#get last update time from memcache
		LastUpdate=`printf "get $SPHINX_INDEXER_KEY\r\n" | $MCCMD |sed -n '2p'`
		#get now unix time
		NowTime=`date +%s`
		#if last time is empty
		if [ ! -n "$LastUpdate" ]; then 
			continue
			#rebuildSphinxIndexes
			#write this time to memcache
			#printf "set $SPHINX_INDEXER_KEY 0 0 10\r\n$NowTime\r\n" | nc 127.0.0.1 11211
		else
			#dis=$[NowTime-LastUpdate]
			dis=$(($NowTime-$LastUpdate))
			#older than 1 minite
			if [[ $dis -gt $MAX_TIME_INTERVAL ]]; then
					#update indexer 
					rebuildSphinxIndexes
					#delete key
					`printf "delete $SPHINX_INDEXER_KEY\r\n" | $MCCMD`
			fi
		fi 
	else
		#echo -e ">>>sphinx indexer is updating..." >> /tmp/updateIndexer.log 2>&1 &
		echo  ">>>sphinx indexer is updating..."
	fi

	sleep $MAX_SLEEP_SECOND
done

