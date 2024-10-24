#!/bin/bash

remote_user="user"
remote_host="172.16.4.2"
remote_script="/home/user/SH/HQ-RTR.sh"

ssh $remote_user@$remote_host "sudo $remote_script"
