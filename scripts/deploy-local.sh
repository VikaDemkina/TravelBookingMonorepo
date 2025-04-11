#!/bin/bash

# Скрипт для локального деплоя монорепозитория
# Просто копирует собранные файлы в указанную директорию

# Настройки
DEPLOY_DIR="$HOME/travelbooking-deploy"
FRONTEND_DIR="$DEPLOY_DIR/frontend"
BACKEND_DIR="$DEPLOY_DIR/backend"
SHARED_DIR="$DEPLOY_DIR/shared"

# Создаем директории если они не существуют
mkdir -p "$FRONTEND_DIR"
mkdir -p "$BACKEND_DIR"
mkdir -p "$SHARED_DIR"

echo "🚀 Начинаем локальный деплой..."

# Копируем frontend
if [ -d "packages/frontend/.next" ]; then
  echo "📦 Копирование frontend..."
  cp -R packages/frontend/.next/* "$FRONTEND_DIR/"
  cp -R packages/frontend/public "$FRONTEND_DIR/" 2>/dev/null || echo "Публичные файлы не найдены"
  cp packages/frontend/package.json "$FRONTEND_DIR/" 2>/dev/null || echo "package.json не найден"
  echo "✅ Frontend скопирован в $FRONTEND_DIR"
else
  echo "⚠️ Frontend build не найден (.next директория отсутствует)"
  touch "$FRONTEND_DIR/.gitkeep"
fi

# Копируем backend
if [ -d "packages/backend/dist" ]; then
  echo "📦 Копирование backend..."
  cp -R packages/backend/dist/* "$BACKEND_DIR/"
  cp packages/backend/package.json "$BACKEND_DIR/" 2>/dev/null || echo "package.json не найден"
  cp packages/backend/prisma/schema.prisma "$BACKEND_DIR/" 2>/dev/null || echo "schema.prisma не найден"
  echo "✅ Backend скопирован в $BACKEND_DIR"
else
  echo "⚠️ Backend build не найден (dist директория отсутствует)"
  touch "$BACKEND_DIR/.gitkeep"
fi

# Копируем shared
if [ -d "packages/shared/dist" ]; then
  echo "📦 Копирование shared..."
  cp -R packages/shared/dist/* "$SHARED_DIR/"
  cp packages/shared/package.json "$SHARED_DIR/" 2>/dev/null || echo "package.json не найден"
  echo "✅ Shared скопирован в $SHARED_DIR"
else
  echo "⚠️ Shared build не найден (dist директория отсутствует)"
  touch "$SHARED_DIR/.gitkeep"
fi

# Завершение
echo "🎉 Локальный деплой завершен!"
echo "📂 Файлы доступны в $DEPLOY_DIR"
echo "🔍 Проверьте логи выше на наличие предупреждений"