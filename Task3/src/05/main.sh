#!/bin/bash

START_TIME=$(date +%s.%N)

source ./var.sh $1

#if [[ $# -ne 1 || ! -d "$1" || "${1: -1}" != "/" ]]; then

