# Руководство по локальному деплою

В этом документе описаны шаги для локального деплоя и запуска приложения TravelBooking.

## Предварительные требования

1. Node.js (версия 16+)
2. npm (версия 7+)
3. Git

## Подготовка

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/VikaDemkina/TravelBookingMonorepo.git
   cd TravelBookingMonorepo
   ```

2. Установите зависимости:
   ```bash
   npm install
   ```

3. Соберите все пакеты:
   ```bash
   npm run build
   ```

## Деплой

### Автоматический деплой

Для автоматического деплоя выполните следующую команду:

```bash
npm run deploy:local
```

Это запустит скрипт `scripts/deploy-local.sh`, который:
- Создаст директории для деплоя в `~/travelbooking-deploy`
- Скопирует собранные файлы из всех пакетов
- Выведет сообщение о результатах деплоя

### Ручной деплой

Если вы хотите выполнить деплой вручную:

1. Создайте директории для деплоя:
   ```bash
   mkdir -p ~/travelbooking-deploy/frontend
   mkdir -p ~/travelbooking-deploy/backend
   mkdir -p ~/travelbooking-deploy/shared
   ```

2. Скопируйте собранные файлы:
   ```bash
   cp -R packages/frontend/.next/* ~/travelbooking-deploy/frontend/
   cp -R packages/frontend/public ~/travelbooking-deploy/frontend/ 2>/dev/null || echo "Публичные файлы не найдены"
   cp packages/frontend/package.json ~/travelbooking-deploy/frontend/
   
   cp -R packages/backend/dist/* ~/travelbooking-deploy/backend/
   cp packages/backend/package.json ~/travelbooking-deploy/backend/
   cp packages/backend/prisma/schema.prisma ~/travelbooking-deploy/backend/
   
   cp -R packages/shared/dist/* ~/travelbooking-deploy/shared/
   cp packages/shared/package.json ~/travelbooking-deploy/shared/
   ```

## Запуск приложения

### Автоматический запуск

Для автоматического запуска приложения выполните:

```bash
npm run start:local
```

Это запустит скрипт `scripts/start-local.sh`, который:
- Запустит backend в режиме детача
- Запустит frontend в режиме детача
- Выведет URL'ы для доступа к приложению
- Запишет логи в `~/travelbooking-deploy/app.log`

После запуска:
- Frontend будет доступен по адресу: http://localhost:5080
- Backend API будет доступен по адресу: http://localhost:3001

### Ручной запуск

Если вы хотите запустить приложение вручную:

1. Запустите backend:
   ```bash
   cd ~/travelbooking-deploy/backend
   node index.js
   ```

2. В отдельном терминале запустите frontend:
   ```bash
   cd ~/travelbooking-deploy/frontend
   npx next start -p 5080
   ```

## Остановка приложения

Если вы запустили приложение через `npm run start:local`, просто нажмите `Ctrl+C` в терминале, где запущен скрипт.

Если вы запустили компоненты вручную, используйте `Ctrl+C` в каждом терминале, где они запущены.

## Мониторинг и логи

Логи автоматически записываются в файл `~/travelbooking-deploy/app.log`.

Просмотр логов в реальном времени:
```bash
tail -f ~/travelbooking-deploy/app.log
```

## Устранение неполадок

1. **Проблема**: Приложение не запускается
   **Решение**: Проверьте, что вы выполнили сборку проекта перед деплоем (`npm run build`)

2. **Проблема**: Порты уже заняты
   **Решение**: Убедитесь, что порты 3001 и 5080 не используются другими приложениями

3. **Проблема**: Файлы не скопировались
   **Решение**: Проверьте, что сборка прошла успешно, директории `.next` и `dist` существуют

4. **Проблема**: Скрипты не запускаются
   **Решение**: Убедитесь, что скрипты имеют права на выполнение:
   ```bash
   chmod +x scripts/*.sh
   ```