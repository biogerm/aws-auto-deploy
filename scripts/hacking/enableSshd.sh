#!/bin/bash
ssh root@localhost -p 7022 'echo "#!/bin/bash" > /var/root/.ssh/sshd.sh;echo "launchctl load -w /System/Library/LaunchDaemons/ssh.plist" >> /var/root/.ssh/sshd.sh;echo "sleep 20" >> /var/root/.ssh/sshd.sh;echo "" >> /var/root/.ssh/sshd.sh'
ssh root@localhost -p 7022 'chmod 755 /var/root/.ssh/sshd.sh'
scp -P 7022 /home/ubuntu/script/com.apple.sshd.plist root@localhost:/Library/LaunchDaemons/
ssh root@localhost -p 7022 'chmod 644 /Library/LaunchDaemons/com.apple.sshd.plist'
ssh root@localhost -p 7022 'launchctl load -w /Library/LaunchDaemons/com.apple.sshd.plist'

