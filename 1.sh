#!/bin/bash
key_path="$HOME/.ssh/id_rsa"  # Путь к ключу
key_size=2048 # Размер ключа

# Удаление старых ключей (будьте осторожны!)
rm -f "$key_path" "$key_path.pub"

# Генерация ключа без пароля
ssh-keygen -t rsa -b "$key_size" -f "$key_path" -N "" > /dev/null 2>&1

echo "Ключ SSH сгенерирован в $key_path и $key_path.pub"
echo "Внимание! Ключ сгенерирован без пароля, это снижает безопасность!"

# Копирование публичного ключа на сервер (НЕОБЯЗАТЕЛЬНО, требует ssh-copy-id)

#Введите имя пользователя и IP сервера
ssh-copy-id user@172.16.4.2
