#!bin/bash
echo NAPISHY PAROL 'P@ssw0rd'
scp -r /home/user/SH/* user@192.168.100.2:/home/user/SH
echo NAPISHY PAROL 'resu'
ssh user@192.168.100.2 "sudo bash /home/user/SH/HQ-SRV.sh"
