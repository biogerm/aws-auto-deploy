#!/bin/bash

power_state="off"
current="5"
while true ; do
   volumes=`ssh root@localhost -p 7822 ls -a /Volumes`
   number_of_volumes=`ssh root@localhost -p 7822 ls -lah /Volumes | wc -l`
   echo `date +%Y%m%d' '%H:%M:%S`" Volumes: "$volumes
   echo `date +%Y%m%d' '%H:%M:%S`" Number of volumes: "$number_of_volumes
   if [ $number_of_volumes -eq $current ] ; then
      echo `date +%Y%m%d' '%H:%M:%S`" Volume identical: [ "$volumes" ]"
      if [ $power_state == "off" ] ; then
        echo `date +%Y%m%d' '%H:%M:%S`" off->on"
        echo `date +%Y%m%d' '%H:%M:%S`" Volume: [ "$volumes" ]" | mail -s "[rMBP]Power on detected" qin.an@ericsson.com
        power_state="on"
      fi
   else
      if [ $number_of_volumes -eq "0" ] ; then
        echo `date +%Y%m%d' '%H:%M:%S`": no connection"
        if [ $power_state == "on" ] ; then
          echo `date +%Y%m%d' '%H:%M:%S`" on->off"
          echo `date +%Y%m%d' '%H:%M:%S` | mail -s "[rMBP]Power off detected" qin.an@ericsson.com
          power_state="off"
        fi
      else
        echo `date +%Y%m%d' '%H:%M:%S`" Volume changed: [ "$volumes" ]"
        echo "Volume list: " $volumes | mail -s "[rMBP]Strange file found" qin.an@ericsson.com
        current=$number_of_volumes
      fi
   fi
   sleep 300
done

