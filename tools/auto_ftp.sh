#!/usr/bin/env bash
# usage
GET_FILENAME="testDownload"
PUT_GET_FILENAME="testDownload"
SERVE_IP="172.10.11.11"
USER="annoymous"
PASS=""
FTP=/usr/bin/ftp

$FTP -n $SERVE_IP <<EOF # -n �ر�ftp�Զ���¼ģʽ
quote USER $USER
quote PASS $PASS
Binary
get $GET_FILENAME #get�������������ļ�
cd upload
put $PUT_GET_FILENAME #post�����ϴ��ļ�
EOF