#!/bin/bash

if [ -z "$1" ]; then
  echo "Error: You entered a void argument."
elif [[ "$1" =~ ^[0-9]+$ ]]; then
  echo "Error: Invalid string"
else
  echo "$1"
fi
