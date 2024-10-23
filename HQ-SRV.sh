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

cp /etc/net/sysctl.conf /etc/net/sysctl.conf.bak
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/net/sysctl.conf
systemctl restart network
apt-get install frr -y
sed -i 's/ospfd=no/ospfd=yes/g' /etc/frr/daemons
systemctl enable --now frr
sh SH/frrH.sh
iptables -t nat -A POSTROUTING -o enp6s18 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables
systemctl enable --now iptables
apt-get remove git -y
history -c
rm -rf SH
exec bash
