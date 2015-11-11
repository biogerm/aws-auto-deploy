#!/bin/bash
power_state="off"
while true ; do
    something="ssh root@localhost -o ConnectTimeOut=20 -p 7822 date"
    result=`eval $something`
    isConnected=`eval $something 2>&1 | grep 2014 | wc -l`
    echo "result="$result
    echo $isConnected
    if [ $isConnected -eq "1" ] ; then
	if [ $power_state == "off" ] ; then
	    echo `date +%Y%m%d' '%H:%M:%S`" seems RMBP is up: $result " | mail -s "RMBP up $isConnected" qin.an@ericsson.com
	fi
	echo `date +%Y%m%d' '%H:%M:%S`" Something interesting"
	ssh root@localhost -p 7822 "curl http://ipecho.net/plain"
	ssh root@localhost -p 7822 "ls -R /Users/biogerm/Pictures/" 2>&1 >> /home/ubuntu/log/rmbp/file.log
	power_state="on"
    else
	if [ $power_state == "on" ] ; then
            echo `date +%Y%m%d' '%H:%M:%S`" seems RMBP is down: $result" | mail -s "RMBP down $isConnected" qin.an@ericsson.com
        fi
	echo `date +%Y%m%d' '%H:%M:%S`" nothing"
	power_state="off"
    fi
    sleep 10
done
