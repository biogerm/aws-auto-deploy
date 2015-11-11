#!/bin/bash
power_state="off"
while true ; do
    something="ssh root@localhost -o ConnectTimeOut=20 -p 7022 date"
    result=`eval $something`
    isConnected=`eval $something 2>&1 | grep 2014 | wc -l`
    echo "result="$result
    echo $isConnected
    if [ $isConnected -eq "1" ] ; then
        if [ $power_state == "off" ] ; then
            echo `date +%Y%m%d' '%H:%M:%S`" seems MBA is up: $result " | mail -s "MBA up $isConnected" qin.an@ericsson.com
        fi
        echo `date +%Y%m%d' '%H:%M:%S`" Something interesting"
	ssh root@localhost -p 7022 "curl http://ipecho.net/plain" > /home/ubuntu/log/mba/ippub.txt
	ssh root@localhost -p 7022 "ifconfig" > /home/ubuntu/log/mba/ifconfig.txt
	#ssh root@localhost -p 7022 "ls -R /Users/sera/Pictures/" 2>&1 >> /home/ubuntu/log/mba/file.log
        power_state="on"
    else
        if [ $power_state == "on" ] ; then
            echo `date +%Y%m%d' '%H:%M:%S`" seems MBA is down: $result" | mail -s "MBA down $isConnected" qin.an@ericsson.com
        fi
        echo `date +%Y%m%d' '%H:%M:%S`" nothing"
        power_state="off"
    fi
    sleep 10
done


