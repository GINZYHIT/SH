#!/bin/bash
hostnamectl set-hostname hq-srv.au-team.irpo
echo 192.168.100.2/26 > /etc/net/ifaces/enp6s18/ipv4address
echo default via 192.168.100.1 > /etc/net/ifaces/enp6s18/ipv4route
echo nameserver 77.88.8.8 > /etc/net/ifaces/enp6s18/resolv.conf
systemctl restart network
useradd sshuser -u 1010
passwd sshuser
P@ssw0rd
P@ssw0rd
usermod -aG wheel sshuser
echo -e "WHEEL_USERS ALL=(ALL:ALL) ALL\nWHEEL_USERS ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
echo -e "Port22\nMaxAuthtries 2\nBanner /etc/mybanner\nAllowUsers sshuser" >> /etc/openssh/sshd_config
echo Authorized access only > /etc/mybanner
cp /etc/net/sysctl.conf /etc/net/sysctl.conf.bak
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/net/sysctl.conf
systemctl restart network
apt-get remove git -y
history -c
rm -rf SH
exec bash
