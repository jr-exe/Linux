#!/bin/bash
#Имя пользователя|имя группы|дом. директория|хеш пароля
count=1
while read S
do
echo "Пользователь $count"                                      # Читаем файл построчно
name=$(echo $S| awk '{print $1}')                               # Парсим имя
group=$(echo $S| awk '{print $2}')                              # Парсим группу
home_dir=$(echo $S| awk '{print $3}')                           # Парсим дом. директорию                    
passwd=$(echo $S| awk '{print $4}')                             # Парсим пароль
#echo $name;echo $group;echo $home_dir;echo $passwd
passwd_cr=$(echo $(openssl passwd -6 -salt xyz $passwd))                       # Шифруем пароль
groupadd -f $group && useradd -m $name -g $group -d $home_dir -p $passwd_cr    #создаем пользователя
let count=$count+1
done < $1