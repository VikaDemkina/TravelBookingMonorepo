#!/bin/bash

# Скрипт для запуска локально развернутого приложения

# Настройки
DEPLOY_DIR="$HOME/travelbooking-deploy"
FRONTEND_DIR="$DEPLOY_DIR/frontend"
BACKEND_DIR="$DEPLOY_DIR/backend"
LOG_FILE="$DEPLOY_DIR/app.log"

# Проверяем, существуют ли директории
if [ ! -d "$FRONTEND_DIR" ] || [ ! -d "$BACKEND_DIR" ]; then
  echo "❌ Ошибка: Директории деплоя не найдены!"
  echo "Сначала выполните деплой с помощью ./scripts/deploy-local.sh"
  exit 1
fi

# Функция для очистки при завершении
cleanup() {
  echo "🛑 Останавливаем процессы..."
  # Находим и убиваем процессы
  if [ ! -z "$BACKEND_PID" ]; then
    kill $BACKEND_PID 2>/dev/null || echo "Backend уже остановлен"
  fi
  if [ ! -z "$FRONTEND_PID" ]; then
    kill $FRONTEND_PID 2>/dev/null || echo "Frontend уже остановлен"
  fi
  echo "👋 Все процессы остановлены"
  exit 0
}

# Устанавливаем обработчик сигналов
trap cleanup SIGINT SIGTERM

# Очищаем лог-файл
> "$LOG_FILE"

echo "🚀 Запускаем приложение из $DEPLOY_DIR..."

# Запускаем backend
echo "🔌 Запускаем Backend API..."
cd "$BACKEND_DIR"
node index.js >> "$LOG_FILE" 2>&1 &
BACKEND_PID=$!
echo "✅ Backend запущен с PID: $BACKEND_PID"

# Немного ждем, чтобы API успел запуститься
sleep 2

# Запускаем frontend
echo "🖥️ Запускаем Frontend..."
cd "$FRONTEND_DIR"
npx next start -p 5080 >> "$LOG_FILE" 2>&1 &
FRONTEND_PID=$!
echo "✅ Frontend запущен с PID: $FRONTEND_PID"

echo "✨ Приложение запущено!"
echo "🌐 Frontend доступен по адресу: http://localhost:5080"
echo "🔧 Backend API доступен по адресу: http://localhost:3001"
echo "📝 Логи записываются в: $LOG_FILE"
echo "⚠️ Нажмите Ctrl+C для остановки приложения"

# Ждем, пока пользователь не нажмет Ctrl+C
wait