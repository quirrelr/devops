#!/bin/bash

source ./var.sh

echo -e "\e[${1};${2}mHOSTNAME[0m = \e[${3};${4}m$HOSTNAME[0m"
echo -e "\e[${1};${2}mTIMEZONE[0m = \e[${3};${4}m$TIMEZONE[0m"
echo -e "\e[${1};${2}mUSER[0m = \e[${3};${4}m$USER[0m"
echo -e "\e[${1};${2}mOS[0m = \e[${3};${4}m$OS[0m"
echo -e "\e[${1};${2}mDATE[0m = \e[${3};${4}m$DATE[0m"
echo -e "\e[${1};${2}mUPTIME[0m = \e[${3};${4}m$UPTIME[0m"
echo -e "\e[${1};${2}mUPTIME_SEC[0m = \e[${3};${4}m$UPTIME_SEC[0m"
echo -e "\e[${1};${2}mIP[0m = \e[${3};${4}m$IP[0m"
echo -e "\e[${1};${2}mMASK[0m = \e[${3};${4}m$MASK[0m"
echo -e "\e[${1};${2}mGATEWAY[0m = \e[${3};${4}m$GATEWAY[0m"
echo -e "\e[${1};${2}mRAM_TOTAL[0m = \e[${3};${4}m$RAM_TOTAL[0m"
echo -e "\e[${1};${2}mRAM_USED[0m = \e[${3};${4}m$RAM_USED[0m"
echo -e "\e[${1};${2}mRAM_FREE[0m = \e[${3};${4}m$RAM_FREE[0m"
echo -e "\e[${1};${2}mSPACE_ROOT[0m = \e[${3};${4}m$SPACE_ROOT[0m"
echo -e "\e[${1};${2}mSPACE_ROOT_USED[0m = \e[${3};${4}m$SPACE_ROOT_USED[0m"
echo -e "\e[${1};${2}mSPACE_ROOT_FREE[0m = \e[${3};${4}m$SPACE_ROOT_FREE[0m"
