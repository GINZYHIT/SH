#!/bin/bash
mac_address="BC:24:11:58:C5:61"
while true; do
  if arp -a | grep "$mac_address" > /dev/null; then
    echo "MAC-адрес найден, запуск скрипта..."
    SH/ISP.sh
  fi
  sleep 10 # Проверка каждые 10 секунд
done

