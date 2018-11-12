#!/usr/bin/env bash
TIMESTAM=`date +%Y%m%d%H%M%S`
CURRENT_HTML=/www/express/${TIMESTAM}.html
CURRENT_INDEX=/www/expres/index.html
LN=/bin/ln
RM=/bin/rm
SERVER_LIST=server_list

cat <<EOF >$CURRENT_HTML
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<body>
	<table width="50%" border="1" cellpadding="1" cellspacing="0" align="center">
		<caption>
			<h2>Server Alive Status</h2>
		</caption>
		<tr>
			<th>Server IP</th>
			<th>Server Status</th>
		</tr>
EOF
while read SERVERS; do
    ping $SERVERS -c 3
    if [ $? -eq 0 ]; then
        STATUS=OK
        COLOR=green
    else
        STATUS=FALSE
        COLOR=red
    fi
    echo "<tr><td>$SERVERS</td><td><font color=$COLOR>$SERVERS</font></td></tr>" >> $CURRENT_HTML
done < $SERVER_LIST

cat <<EOF >> $CURRENT_HTML
</table>
</body>
</html>
EOF

$LN -sf $CURRENT_HTML $CURRENT_INDEX