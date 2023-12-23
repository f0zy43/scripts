#!/bin/bash

# Путь к директории, где будут храниться заметки
NOTES_DIR="notes"

# Проверяем, передан ли аргумент
if [ -z $1 ]; then
    echo "Используйте команду './название скрипта' с одним из следующих аргументов: create, edit, search, search_name, move"
    exit 1
fi

# Проверяем переданный аргумент и выполняем соответствующее действие
case $1 in
    "create")
        shift # Удаляем первый аргумент (create) из списка аргументов
        echo "Создание новой заметки..."
	note_title="$1"
        # Открытие редактора vim для создания новой заметки
        vim "$NOTES_DIR/$note_title.txt"
        ;;
    "edit")
        shift
        echo "Редактирование заметки..."
        # Открытие редактора vim для редактирования существующей заметки
        vim "$NOTES_DIR/$1"
        ;;
    "search")
        shift
        echo "Поиск заметок по тегам..."
        # Поиск заметок по тегам
        grep -rl "$1" $NOTES_DIR
        ;;
    "search_name")
	shift
	echo "Поиск заметок по названию..."
	# Поиск по названию
	find -type f -name "$1.txt*"
        ;;
    "move")
    	if [ -z "$2" ] || [ -z "$3" ]; then
        	echo "Переименовать файл..."
        	exit 1
    	fi
    	old_note_title="$NOTES_DIR/$2"
    	new_note_title="$NOTES_DIR/$3"
    	old_note_file="$old_note_title.txt"
    	new_note_file="$new_note_title.txt"
    	mv "$old_note_file" "$new_note_file"
    	if [ $? -eq 0 ]; then
        	echo "Изменен  $old_note_file в  $new_note_file"
    	else
        	echo "Error"
    	fi
    	;;
    *)
        echo "Недопустимый аргумент. Используйте команду 'notes' с одним из следующих аргументов: create, edit, search, search_name, move"      
       	exit 1
        ;;
esac
