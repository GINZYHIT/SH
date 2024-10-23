#!/bin/bash

read -p "sshuser" username
read -s -p "P@ssw0rd $username: " password
echo ""

if id "$username" &> /dev/null; then
  echo "Пользователь с таким именем уже существует."
  exit 1
fi

useradd "$username"
echo "$password" | passwd --stdin "$username"

echo "Пользователь $username создан."
