#!/bin/bash
hostnamectl set-hostname br-srv.au-team.irpo
echo 192.168.0.2/27 > /etc/net/ifaces/enp6s18/ipv4address
echo default via 192.168.0.1 > /etc/net/ifaces/enp6s18/ipv4route
echo nameserver 77.88.8.8 > /etc/net/ifaces/enp6s18/resolv.conf
systemctl restart network
sh SH/sshuser.sh
usermod -aG wheel sshuser
echo -e "WHEEL_USERS ALL=(ALL:ALL) ALL\nWHEEL_USERS ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
echo -e "Port 2024\nMaxAuthTries 2\nBanner /etc/mybanner\nAllowUsers sshuser" >> /etc/openssh/sshd_config
echo Authorized access only > /etc/mybanner
cp /etc/net/sysctl.conf /etc/net/sysctl.conf.bak
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/net/sysctl.conf
echo nameserver 192.168.100.2 > /etc/net/ifaces/enp6s18/resolv.conf
systemctl restart network
systemctl restart sshd
history -c
#apt-get remove git -y
rm -rf SH
clear
