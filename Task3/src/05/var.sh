#!/bin/bash

DIR="$1"

TOTAL_DIRS=$(find "$DIR" -type d | wc -l)
TOP5_DIRS=$(du -h --max-depth=1 "$DIR" 2>/dev/null | sort -hr | head -n 6 | tail -n 5)
TOTAL_FILES=$(find "$DIR" -type f | wc -l)
CONF_FILES=$(find "$1" -type f -name "*.conf" | wc -l)
TEXT_FILES=$(find "$DIR" -type f -exec file --mime-type {} + | grep text | wc -l)
EXEC_FILES=$(find "$1" -type f -executable | wc -l)
LOG_FILES=$(find "$1" -type f -name "*.log" | wc -l)
ARCHIVES=$(find "$1" -type f \
