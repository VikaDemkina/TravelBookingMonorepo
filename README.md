# Travel Booking Monorepo

Монорепозиторий для приложения бронирования путешествий с настройкой CI/CD.

## Структура проекта

- `packages/` - Пакеты и модули приложения
  - `frontend/` - Frontend приложение на Next.js
  - `backend/` - Backend API на Express с Prisma
  - `shared/` - Общие типы и компоненты
- `.github/` - GitHub Actions и workflow для CI/CD
- `docs/` - Документация
- `scripts/` - Скрипты для деплоя и вспомогательных операций

## Быстрый старт

Клонируйте репозиторий и установите зависимости:

```bash
git clone https://github.com/VikaDemkina/TravelBookingMonorepo.git
cd TravelBookingMonorepo
npm install
```

Запустите все сервисы в режиме разработки:

```bash
npm run dev
```

## Локальный деплой

Для локального деплоя и запуска приложения:

```bash
# Сборка всех пакетов
npm run build

# Деплой приложения локально
npm run deploy:local

# Запуск развернутого приложения
npm run start:local
```

После запуска:
- Frontend будет доступен по адресу: http://localhost:5080
- Backend API будет доступен по адресу: http://localhost:3001

Подробная документация по локальному деплою: [LOCAL_DEPLOY.md](./docs/LOCAL_DEPLOY.md)

## Команды

- `npm run dev` - запуск всех пакетов в режиме разработки
- `npm run build` - сборка всех пакетов
- `npm run start` - запуск собранных пакетов
- `npm run lint` - линтинг кода
- `npm run test` - запуск тестов
- `npm run deploy:local` - локальный деплой приложения
- `npm run start:local` - запуск локально развернутого приложения
- `npm run deploy:ci` - сборка и деплой (для CI)
- `npm run metrics` - сбор метрик производительности

## CI/CD и метрики

Этот проект настроен с использованием GitHub Actions для CI/CD. При каждом push в main ветку или создании PR запускаются процессы CI. При успешном merge в main также запускается CD для деплоя.

Мы собираем следующие метрики:
- Время сборки
- Успешность сборок и деплоев
- Другие показатели эффективности

## Документация

- [Руководство по монорепозиторию](./docs/MONOREPO.md)
- [Метрики CI/CD](./docs/METRICS.md)
- [Руководство по миграции](./docs/MIGRATION.md)
- [Локальный деплой](./docs/LOCAL_DEPLOY.md)

## Технологии

- **Frontend**: Next.js, React, MUI, Redux
- **Backend**: Express, Prisma, PostgreSQL
- **Инструменты**: TypeScript, Turborepo, GitHub Actions