#!/bin/bash
while true ; do
echo "Fetching IP"
IP="$(curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')"
echo "${IP}"
echo `date +%Y%m%d' '%H:%M:%S` $IP >> /home/ubuntu/publicIp
echo "IP address is recored on AWS"
echo "Updating no-ip.org"
curl -X GET "http://biogerm:{PASSWORD}@dynupdate.no-ip.com/nic/update?hostname=biogerm.no-ip.org&myip="${IP}
sleep 600
done

