vtysh
vtysh configure terminal
vtysh interface tun0
vtysh ip ospf authentication message-digest
vtysh ip ospf message-digest-key 1 md5 P@ssw0rd
vtysh exit
vtysh router ospf
vtysh network 192.168.100.0/26 area 0
vtysh network 192.168.200.0/28 area 0
vtysh network 192.168.99.0/29 area 0
vtysh network 172.16.30.0/30 area 0
vtysh do wr
vtysh exit
vtysh exit
vtysh exit
