#!/bin/bash

# Функция для чтения цвета из строки color.config:
# возвращает цифру цвета, если есть, или пустую строку, если нет
get_color_from_line() {
  local line_number=$1
  local color_char
  color_char=$(awk "NR==$line_number{print substr(\$0,20,1)}" color.config)

  # Проверяем, что color_char — цифра от 1 до 6, иначе пусто
  if [[ "$color_char" =~ ^[1-6]$ ]]; then
    echo "$color_char"
  else
    echo ""
  fi
}

# Читаем цвета для каждого параметра (4 строки)
c1_back_raw=$(get_color_from_line 1)
c1_fore_raw=$(get_color_from_line 2)
c2_back_raw=$(get_color_from_line 3)
c2_fore_raw=$(get_color_from_line 4)

# Подставляем дефолты, если пусто
c1_back=${c1_back_raw:-6}
c1_fore=${c1_fore_raw:-1}
c2_back=${c2_back_raw:-6}
c2_fore=${c2_fore_raw:-1}

# Проверка на совпадение цвета текста и фона в колонках
if [ "$c1_back" -eq "$c1_fore" ]; then
  echo "ERROR: Column 1 background and foreground colors must differ."
  exit 1
fi
if [ "$c2_back" -eq "$c2_fore" ]; then
  echo "ERROR: Column 2 background and foreground colors must differ."
  exit 1
fi

# Функция вызова num_to_col.sh (для ANSI кода цвета)
color_code() {
  ./num_to_col.sh "$1"
}

# Функция вызова color_num.sh (для имени цвета)
color_name() {
  ./color_num.sh "$1"
}

# Формируем цветовые коды для ANSI escape:
FOREGROUND_NAME=$((30 + $(color_code "$c1_fore")))
BACKGROUND_NAME=$((40 + $(color_code "$c1_back")))
FOREGROUND_VALUE=$((30 + $(color_code "$c2_fore")))
BACKGROUND_VALUE=$((40 + $(color_code "$c2_back")))

# Запускаем printing.sh с цветами
./printing.sh "$FOREGROUND_NAME" "$BACKGROUND_NAME" "$FOREGROUND_VALUE" "$BACKGROUND_VALUE"

# --- Вывод цветовой схемы ---
echo ""
echo -n "Column 1 background = "
if [ -z "$c1_back_raw" ]; then
  echo "default (black)"
else
  echo "$c1_back ($(color_name $c1_back))"
fi

echo -n "Column 1 font color = "
if [ -z "$c1_fore_raw" ]; then
  echo "default (white)"
else
  echo "$c1_fore ($(color_name $c1_fore))"
fi

echo -n "Column 2 background = "
if [ -z "$c2_back_raw" ]; then
  echo "default (black)"
else
  echo "$c2_back ($(color_name $c2_back))"
fi

echo -n "Column 2 font color = "
if [ -z "$c2_fore_raw" ]; then
  echo "default (white)"
else
  echo "$c2_fore ($(color_name $c2_fore))"
fi
