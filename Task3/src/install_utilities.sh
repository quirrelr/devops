#!/bin/bash

# === Путь к файлу конфигурации ===
DEP_FILE="dep.config"

# Проверка существования файла
if [ ! -f "$DEP_FILE" ]; then
    echo "Ошибка: Файл зависимостей $DEP_FILE не найден!"
    exit 1
fi

# === Чтение зависимостей из файла ===
DEPENDENCIES=()
while IFS= read -r line; do
    # Пропускаем пустые строки и комментарии
    [[ -z "$line" || "$line" == \#* ]] && continue
    DEPENDENCIES+=("$line")
done < "$DEP_FILE"

# === Определение пакетного менеджера ===
if command -v apt-get >/dev/null 2>&1; then
    PKG_MANAGER="apt-get"
    INSTALL_CMD="sudo apt-get install -y"
    UPDATE_CMD="sudo apt-get update"
elif command -v pacman >/dev/null 2>&1; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm"
    UPDATE_CMD="sudo pacman -Sy"
else
    echo "Ошибка: Поддерживаемый пакетный менеджер не найден (apt-get или pacman)."
    exit 1
fi

echo "Обнаружен пакетный менеджер: $PKG_MANAGER"

# === Проверка наличия команды ===
is_installed() {
    command -v "$1" >/dev/null 2>&1
}

# === Основной цикл ===
for pkg in "${DEPENDENCIES[@]}"; do
    echo -n "Проверка наличия пакета $pkg... "
    if is_installed "$pkg"; then
        echo "установлен."
    else
        echo "не найден. Устанавливаю..."
        $UPDATE_CMD
        $INSTALL_CMD "$pkg"
        if [ $? -eq 0 ]; then
            echo "$pkg успешно установлен."
        else
            echo "Ошибка при установке $pkg!"
            exit 1
        fi
    fi
done

echo "Все зависимости установлены."
