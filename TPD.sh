#!/bin/bash
# Параметры
interface="eьз6ы19"  # Замените на ваш сетевой интерфейс
remote_host="root@172.16.4.2" # Замените на имя пользователя и удаленный хост
remote_script="SH/HQ-RTR.sh" # Замените на путь к удалённому скрипту
filter="port 8080" # Замените на ваш фильтр tcpdump

# Запуск tcpdump в фоновом режиме с перенаправлением вывода
tcpdump -i $interface -n $filter -w - | while read line; do
  # Проверка на наличие нужного пакета (простая проверка с grep -  не подходит для сложных фильтров)
  if echo "$line" | grep "IP" > /dev/null; then
    echo "Обнаружен пакет, запуск удалённого скрипта..."
    ssh $remote_host "$remote_script"
  fi
done

