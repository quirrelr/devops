#!/bin/bash

directory=$1

# Total number of folders (including nested)
total_folders=$(find "$directory" -type d | wc -l)

# Top 5 folders by size
top_5_folders=$(du -h --max-depth=1 "$directory" 2>/dev/null | sort -hr | head -n 5)

# Total number of files
total_files=$(find "$directory" -type f | wc -l)

# File type counts
conf_files=$(find "$directory" -type f -name "*.conf" | wc -l)
text_files=$(find "$directory" -type f -exec file --mime-type {} + | grep 'text/plain' | wc -l)
exec_files=$(find "$directory" -type f -executable | wc -l)
log_files=$(find "$directory" -type f -name "*.log" | wc -l)
archive_files=$(find "$directory" -type f \( -name "*.tar" -o -name "*.gz" -o -name "*.zip" -o -name "*.rar" -o -name "*.7z" \) | wc -l)
symlinks=$(find "$directory" -type l | wc -l)

# Top 10 files by size (path, size, type)
top_10_files=$(find "$directory" -type f -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | awk '{print $2}' | while read file; do
  size=$(du -h "$file" | awk '{print $1}')
  type=$(file -b "$file" | awk '{print $1}')
  echo "$file, $size, $type"
done)

# Top 10 executable files by size (path, size, md5 hash)
top_10_exec=$(find "$directory" -type f -executable -exec du -h {} + 2>/dev/null | sort -hr | head -n 10 | awk '{print $2}' | while read file; do
  size=$(du -h "$file" | awk '{print $1}')
  hash=$(md5sum "$file" | awk '{print $1}')
  echo "$file, $size, $hash"
done)

# Экспортируем переменные в окружение
export total_folders total_files conf_files text_files exec_files log_files archive_files symlinks
export top_5_folders top_10_files top_10_exec
