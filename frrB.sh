#!/bin/sh
vtysh -c "configure terminal" \
      -c "interface tun0" \
      -c "ip ospf authentication message-digest" \
      -c "ip ospf message-digest-key 1 md5 P@ssw0rd" \
      -c "no ip ospf network broadcast" \
      -c "exit" \
      -c "router ospf" \
      -c "network 192.168.0.0/27 area 0" \
      -c "network 172.16.30.0/30 area 0" \
      -c "do wr" \
      -c "exit" \
      -c "exit" \
      -c "exit" \
