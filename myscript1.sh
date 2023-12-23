#!/bin/bash

# Проверяем, существует ли файл для хранения счетчика
if [ ! -f command_file ]; then
    echo "0" > command_file
fi

# Читаем счетчик из файла
count=$(< command_file)

# Увеличиваем счет на 1
((count++))

# Записываем обновленный счетчик обратно в файл
echo "$count" > command_file

# Получаем время загрузки системы и преобразуйте его в секунды с начала
boot_time=$(date -d "$(awk '{print int($1)}' /proc/uptime) seconds ago" "+%s")

# Получаем текущее время в секундах с начала
current_time=$(date "+%s")

#  Подсчитатываем количество запусков скрипта после последней перезагрузки
run_boot=$((count - 1))

# Подсчитатываем общее количество запусков скрипта
run_total=$((count + (current_time - boot_time) / 60))

# вывод рузультата
echo "запуски: $run_total"
echo "запуски после перезагрузки: $run_boot"
