#!/bin/bash

source ./var.sh

RANDOMNAME=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 15)

{
  echo "HOSTNAME = $HOSTNAME"
  echo "TIMEZONE = $TIMEZONE"
  echo "USER = $USER"
  echo "OS = $OS"
  echo "DATE = $DATE"
  echo "UPTIME = $UPTIME"
  echo "UPTIME_SEC = $UPTIME_SEC"
  echo "IP = $IP"
  echo "MASK = $MASK"
  echo "GATEWAY = $GATEWAY"
  echo "RAM_TOTAL = $RAM_TOTAL"
  echo "RAM_USED = $RAM_USED"
  echo "RAM_FREE = $RAM_FREE"
  echo "SPACE_ROOT = $SPACE_ROOT"
  echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
  echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
} | tee $RANDOMNAME

echo "__________________________________________"
echo
echo "Do you want to write the data to a file? Y/N"
read REQUEST
if [[ $REQUEST =~ ^[Yy]$ ]] ; then
  cp $RANDOMNAME $FILENAME
  echo
  echo "File have been created successfully!"
fi
rm $RANDOMNAME
