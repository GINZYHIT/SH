#!/bin/bash
mac_address="XX:XX:XX:XX:XX:XX"
while true; do
  if arp -a | grep "$mac_address" > /dev/null; then
    echo "MAC-адрес найден, запуск скрипта..."
    SH/ISP.sh
  fi
  sleep 10 # Проверка каждые 10 секунд
done

