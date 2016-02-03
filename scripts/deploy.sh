#!/bin/bash
echo "Please input ppp password:"
read KEY
if [ "$KEY" = "" ]; then
   echo "Empty key"
   exit
fi

# Install Emacs and PPTPD
sudo apt-get -q -y install emacs23 pptpd

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

sudo /etc/init.d/pptpd restart
echo "PPTP ready"

