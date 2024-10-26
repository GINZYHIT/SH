#!/bin/bash
apt-get install tzdata -y
timedatectl set-timezone Europe/Moscow
apt-get install iptables -y
mkdir /etc/net/ifaces/enp6s{19,20}
cp /etc/net/ifaces/enp6s18/options /etc/net/ifaces/enp6s19/
cp /etc/net/ifaces/enp6s18/options /etc/net/ifaces/enp6s20/
echo -e "BOOTPROTO=static\nTYPE=eth" > /etc/net/ifaces/enp6s19/options
echo -e "BOOTPROTO=static\nTYPE=eth" > /etc/net/ifaces/enp6s20/options
touch /etc/net/ifaces/enp6s19/ipv4address
touch /etc/net/ifaces/enp6s20/ipv4address
cp /etc/net/sysctl.conf /etc/net/sysctl.conf.bak
sed -i 's/net.ipv4.ip_forward = 0/net.ipv4.ip_forward = 1/g' /etc/net/sysctl.conf
iptables -t nat -A POSTROUTING -o enp6s18 -j MASQUERADE
iptables-save > /etc/sysconfig/iptables
echo 172.16.4.1/28 > /etc/net/ifaces/enp6s19/ipv4address
echo 172.16.5.1/28 > /etc/net/ifaces/enp6s20/ipv4address
hostnamectl set-hostname isp.au-team.irpo
systemctl enable --now iptables
systemctl restart network
#sh SH/1.sh
echo VVEDY YES I NAPISHY PAROL 'P@ssw0rd'
scp -r /root/SH/* user@172.16.4.2:/home/user/SH
echo VVEDY YES I NAPISHY 'P@ssw0rd'
scp -r /root/SH/* user@172.16.5.2:/home/user/SH
echo NAPISHY PAROL 'P@ssw0rd'
ssh user@172.16.4.2 "sudo bash /home/user/SH/HQ-RTR.sh"
echo NAPISHY PAROL 'P@ssw0rd'
ssh user@172.16.5.2 "sudo bash /home/user/SH/BR-RTR.sh"
#sudo sh SH/HQ-RTR.sh

apt-get remove git -y
history -c
rm -rf SH
clear
exec bash
