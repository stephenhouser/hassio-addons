#!/bin/bash
set -e

owserver --error_level=2 -c /etc/owfs.conf --foreground

#mkdir -p /var/run/sshd
#echo "root:password" | chpasswd 2&> /dev/null
#sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config
#sed -i s/#LogLevel.*/LogLevel\ DEBUG/ /etc/ssh/sshd_config
#sed -i s/#PasswordAuthentication.*/PasswordAuthentication\ yes/ /etc/ssh/sshd_config
#sed -i s/#PermitEmptyPasswords.*/PermitEmptyPasswords\ no/ /etc/ssh/sshd_config
#exec /usr/sbin/sshd -D -e < /dev/null
