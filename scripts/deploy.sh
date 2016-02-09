#!/bin/bash
echo "Please input ppp password:"
read KEY
if [ "$KEY" = "" ]; then
   echo "Empty key"
   exit
fi
echo "Please input DDNS password:"
read DDNS_KEY
if [ "$DDNS_KEY" = "" ]; then
   echo "Empty key"
   exit
fi


# Install Emacs and PPTPD
sudo apt-get -q -y install emacs23 pptpd
cp ../configs/.emacs /home/ubuntu/

# Enable IPv4 port forwarding
sudo sed -i -r 's/^\s*#(net\.ipv4\.ip_forward=1.*)/\1/' /etc/sysctl.conf
# Reload the config file to have the change take effect immediately.
sudo -i sysctl -p

OUTIF=`/sbin/ip route show to exact 0/0 | sed -r 's/.*dev\s+(\S+).*/\1/'`
##sudo -i iptables --table nat --append POSTROUTING --out-interface $OUTIF --jump MASQUERADE
# Enable NAT on boot from the rc.local script.
CMD="iptables --table nat --append POSTROUTING --out-interface $OUTIF --jump MASQUERADE"

sudo -i $CMD
sudo sed -i "\$i$CMD\n" /etc/rc.local

echo "biogerm pptpd $KEY *" | sudo tee -a /etc/ppp/chap-secrets
echo "ms-dns 8.8.8.8" | sudo tee -a /etc/ppp/pptpd-options
echo "ms-dns 8.8.4.4" | sudo tee -a /etc/ppp/pptpd-options
sudo /etc/init.d/pptpd restart
echo "PPTP ready"

# Enable report DDNS on startup
CMD="`pwd`/report-ddns.sh >> /home/ubuntu/reportddns.log &"
sudo sed -i "\$i$CMD\n" /etc/rc.local

# Replace keys in the DDNS script
sed -i "s/{PASSWORD}/$DDNS_KEY/g" report-ddns.sh

