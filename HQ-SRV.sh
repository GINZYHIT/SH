#!/bin/bash
hostnamectl set-hostname hq-srv.au-team.irpo
echo 192.168.100.2/26 > /etc/net/ifaces/enp6s18/ipv4address
echo default via 192.168.100.1 > /etc/net/ifaces/enp6s18/ipv4route
echo nameserver 77.88.8.8 > /etc/net/ifaces/enp6s18/resolv.conf
systemctl restart network
sh SH/sshuser.sh
usermod -aG wheel sshuser
echo -e "WHEEL_USERS ALL=(ALL:ALL) ALL\nWHEEL_USERS ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
echo -e "Port 2024\nMaxAuthTries 2\nBanner /etc/mybanner\nAllowUsers sshuser" >> /etc/openssh/sshd_config
echo Authorized access only > /etc/mybanner
cp /etc/net/sysctl.conf /etc/net/sysctl.conf.bak
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/net/sysctl.conf
systemctl restart network
systemctl restart sshd
# bind
apt-get update
apt-get install bind bind-utils -y
echo nameserver 127.0.0.1 > /etc/net/ifaces/enp6s18/resolv.conf
systemctl restart network
mv -f SH/options.conf /etc/bind/options.conf
systemctl enable --now bind
mv -f SH/au-team.irpo /etc/bind/zone/au-team.irpo
chown named:named /etc/bind/zone/au-team.irpo
mv -f SH/rfc1912.conf /etc/bind/rfc1912.conf
systemctl restart bind
mv -f SH/168.192.in-addr.arpa /etc/bind/zone/168.192.in-addr.arpa
chown named:named /etc/bind/zone/168.192.in-addr.arpa
systemctl restart bind
host 192.168.100.2 127.0.0.1
host 192.168.100.2 127.0.0.1
# clear history
history -c
#apt-get remove git -y
rm -rf SH
clear
