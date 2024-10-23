#!/bin/bash

useradd "sshuser"
echo "P@ssw0rd" | passwd --stdin "sshuser"

echo "Пользователь sshuser создан."
