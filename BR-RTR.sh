#!/bin/bash
hostnamectl set-hostname br-rtr.au-team.irpo
mkdir /etc/net/ifaces/enp6s19
mkdir /etc/net/ifaces/tun0
cp /etc/net/ifaces/enp6s18/options /etc/net/ifaces/enp6s19/
echo 172.16.5.2/28 > /etc/net/ifaces/enp6s18/ipv4address
echo default via 172.16.5.1 > /etc/net/ifaces/enp6s18/ipv4route
echo nameserver 77.88.8.8 > /etc/net/ifaces/enp6s18/resolv.conf
echo 192.168.0.1/27 > /etc/net/ifaces/enp6s19/ipv4address
echo 172.16.30.2/30 > /etc/net/ifaces/tun0/ipv4address
echo -e "TYPE=iptun\nTUNTYPE=gre\nTUNLOCAL=172.16.5.2\nTUNREMOTE=172.16.4.2\nTUNTTL=64\nTUNMTU=1400\nTUNOPTIONS='ttl 64'" > /etc/net/ifaces/tun0/options
cp /etc/net/sysctl.conf /etc/net/sysctl.conf.bak
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/net/sysctl.conf
systemctl restart network
apt-get install frr -y
sed -i 's/ospfd=no/ospfd=yes/g' /etc/frr/daemons
systemctl enable --now frr
sh SH/frrB.sh
iptables -t nat -A POSTROUTING -o enp6s18 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables
systemctl enable --now iptables
#apt-get remove git -y
echo VVEDY YES I NAPISHY PAROL 'resu'
scp -r /home/user/SH/* user@192.168.0.2:/home/user/SH

history -c
rm -rf SH
clear

