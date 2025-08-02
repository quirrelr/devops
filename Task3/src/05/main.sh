#!/bin/bash

start_time=$(date +%s.%N)

# Проверка аргумента
if [ $# -ne 1 ]; then
  echo "Usage: $0 <directory_path>/"
  exit 1
fi

directory=$1

if [ ! -d "$directory" ] || [[ "$directory" != */ ]]; then
  echo "Error: Directory doesn't exist or path doesn't end with '/'."
  exit 1
fi

# Подгружаем var.sh
source ./var.sh "$directory"

# Вывод информации
echo "Total number of folders (including all nested ones) = $total_folders"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
i=1
echo "$top_5_folders" | while read line; do
  folder=$(echo "$line" | awk '{print $2}')
  size=$(echo "$line" | awk '{print $1}')
  echo "$i - $folder, $size"
  i=$((i+1))
done

echo "Total number of files = $total_files"
echo "Number of:"
echo "Configuration files (with the .conf extension) = $conf_files"
echo "Text files = $text_files"
echo "Executable files = $exec_files"
echo "Log files (with the extension .log) = $log_files"
echo "Archive files = $archive_files"
echo "Symbolic links = $symlinks"

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
i=1
echo "$top_10_files" | while read line; do
  echo "$i - $line"
  i=$((i+1))
done

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
i=1
echo "$top_10_exec" | while read line; do
  echo "$i - $line"
  i=$((i+1))
done

end_time=$(date +%s.%N)
execution_time=$(echo "$end_time - $start_time" | bc)

echo "Script execution time (in seconds) = $execution_time"