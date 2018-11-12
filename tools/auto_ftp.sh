#!/usr/bin/env bash
# usage
GET_FILENAME="testDownload"
PUT_GET_FILENAME="testDownload"
SERVE_IP="172.10.11.11"
USER="annoymous"
PASS=""
FTP=/usr/bin/ftp

$FTP -n $SERVE_IP <<EOF # -n 关闭ftp自动登录模式
quote USER $USER
quote PASS $PASS
Binary
get $GET_FILENAME #get命令用于下载文件
cd upload
put $PUT_GET_FILENAME #post用于上传文件
EOF