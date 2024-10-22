#!/bin/bash
mkdir /etc/net/ifaces/enp6s{19.100,19.200,19.999}
mkdir /etc/net/ifaces/tun0
echo 172.16.4.2/28 > /etc/net/ifaces/enp6s18/ipv4address
echo default via 172.16.4.1 > /etc/net/ifaces/enp6s18/ipv4route
echo nameserver 77.88.8.8 > /etc/net/ifaces/enp6s18/resolv.conf
echo 192.168.100.1/26 > /etc/net/ifaces/enp6s19.100/ipv4address
echo 192.168.200.1/28 > /etc/net/ifaces/enp6s19.200/ipv4address
echo 192.168.99.1/29 > /etc/net/ifaces/enp6s19.999/ipv4address
echo 172.16.30.1/30 > /etc/net/ifaces/tun0/ipv4address
echo -e "TYPE=vlan\nHOST=enp6s19\nVID=100\nBOOTPROTO=static" > /etc/net/ifaces/enp6s19.100/options
echo -e "TYPE=vlan\nHOST=enp6s19\nVID=200\nBOOTPROTO=static" > /etc/net/ifaces/enp6s19.200/options
echo -e "TYPE=vlan\nHOST=enp6s19\nVID=999\nBOOTPROTO=static" > /etc/net/ifaces/enp6s19.999/options
echo -e "TYPE=iptun\nTUNTYPE=gre\nTUNLOCAL=172.16.4.2\nTUNREMOTE=172.16.5.2\nTUNTTL=64\nTUNMTU=1400\nTUNOPTIONS='ttl 64'" > /etc/net/ifaces/tun0/options
cp /etc/net/sysctl.conf /etc/net/sysctl.conf.bak
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/net/sysctl.conf
systemctl restart network
apt-get install frr -y
sed -i 's/ospfd=no/ospfd=yes/g' /etc/frr/daemons
systemctl enable --now frr
echo -e "frr version 9.0.2\nfrr defaults traditional\nhostname hq-rtr\nlog file /var/log/frr/frr.log\nno ipv6 forwarding\n!\ninterface tun0\n ip ospf authentication message-digest\n ip ospf message-digest-key 1 md5 P@ssw0rd\nexit\n!\nrouter ospf\n network 192.168.100.0/26 area 0\n network 192.168.200.0/28 area 0\n network 192.168.99.0/29 area 0\n network 172.16.30.0/30 area 0\nexit\n!" > /etc/frr/frr.conf
iptables -t nat -A POSTROUTING -o enp6s18 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables
hostnamectl set-hostname isphq-rtr.au-team.irpo
exec bash
systemctl enable --now iptables
