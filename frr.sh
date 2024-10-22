vtysh
  configure terminal
    interface tun0
      ip ospf authentication message-digest
      ip ospf message-digest-key 1 md5 P@ssw0rd
      exit
    router ospf
      network 192.168.100.0/26 area 0
      network 192.168.200.0/28 area 0
      network 192.168.99.0/29 area 0
      network 172.16.30.0/30 area 0
      do wr
      exit
    exit
  exit
