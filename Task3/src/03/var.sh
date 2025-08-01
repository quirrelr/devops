#!/bin/bash

TIMEZONE="$(timedatectl status | grep "Time zone:" | awk '{print $3}') UTC $(timedatectl | grep "Time zone:" | awk '{print $5}' | tr -d ')0')"

OS=$(cat /etc/os-release | grep "PRETTY_NAME" | awk '{print substr($1, length($1)-5, 6), $2, $3}'  | tr -d '\"')

DATE=$(date | awk '{print $2, $3, $4, $5}')

UPTIME_SEC=$(awk '{print $1}' /proc/uptime)

UPTIME=$(uptime | awk '{print $3}' | tr -d ',')

IP=$(ip -4 -o a show enp0s3 | awk '{split($4, a, "/"); print a[1]}')

MASK_PREFIX=$(ip -4 -o a show enp0s3 | awk '{split($4, a, "/"); print a[2]}')

MASK=$(ipcalc $MASK_PREFIX | grep "Netmask" | awk '{print $2}')

GATEWAY=$(ip r show default | awk '{print $3}')

RAM_TOTAL=$(free | grep "Mem:" | awk '{printf "%.3f GB\n", $2/1024/1024}')

RAM_USED=$(free | grep "Mem:" | awk '{printf "%.3f GB\n", $3/1024/1024}')

RAM_FREE=$(free | grep "Mem:" | awk '{printf "%.3f GB\n", $4/1024/1024}')

SPACE_ROOT=$(df / | grep "/dev" | awk '{printf "%.2f", $2/1024}')

SPACE_ROOT_USED=$(df / | grep "/dev" | awk '{printf "%.2f", $3/1024}')

SPACE_ROOT_FREE=$(df / | grep "/dev" | awk '{printf "%.2f", $4/1024}')
