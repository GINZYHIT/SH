#!/bin/bash
apt-get update
apt-get install bind bind-utils -y
echo nameserver 127.0.0.1 > /etc/net/ifaces/enp6s18/resolv.conf
systemctl restart network
mv -f SH/options.conf /etc/bind/options.conf
