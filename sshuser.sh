#!/bin/bash

useradd "sshuser" -u 1010
echo "P@ssw0rd" | passwd --stdin "sshuser"

echo "Пользователь sshuser создан."
