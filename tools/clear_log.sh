#!/usr/bin/env bash
export PATH=$PATH:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:./
TMP_DIR=/tmp/
TODAY=$(date +%Y-%m-%d)
LASTWEEK=`date -d last-week +%Y-%m-%d`
LOG_FILES=$(ls $TMP_DIR| grep `date +%Y`)

for i in $LOG_FILES;
do
    if [[ -d $i ]]&&[[ $i < $LASTWEEK ]];then
        echo "ready delte $TMP_DIR$i"
        rm -rf ${TMP_DIR}${i}
    fi
done
