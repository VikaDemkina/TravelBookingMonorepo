# Руководство по монорепозиторию

В этом документе описана структура монорепозитория, принципы его организации и инструкции по работе с ним.

## Структура проекта

```
TravelBookingMonorepo/
├── packages/                   # Пакеты приложения
│   ├── frontend/              # Frontend приложение на Next.js
│   │   ├── src/               # Исходный код frontend
│   │   ├── package.json       # Зависимости и скрипты frontend
│   │   └── tsconfig.json      # Конфигурация TypeScript для frontend
│   ├── backend/               # Backend API
│   │   ├── src/               # Исходный код backend
│   │   ├── prisma/            # База данных и миграции
│   │   ├── package.json       # Зависимости и скрипты backend
│   │   └── tsconfig.json      # Конфигурация TypeScript для backend
│   └── shared/                # Общий код для других пакетов
│       ├── src/               # Общие компоненты, типы и утилиты
│       ├── package.json       # Зависимости и скрипты shared
│       └── tsconfig.json      # Конфигурация TypeScript для shared
├── .github/                   # GitHub Actions и скрипты CI/CD
│   ├── workflows/             # Файлы конфигурации GitHub Actions
│   └── scripts/               # Скрипты для сбора метрик и других задач
├── docs/                      # Документация проекта
├── package.json               # Корневой package.json с workspaces
└── turbo.json                 # Конфигурация Turborepo
```

## Пакеты

### frontend

Frontend приложение на Next.js. Отвечает за пользовательский интерфейс и взаимодействие с backend API.

Основные технологии:
- Next.js
- React
- Redux
- Material UI
- TypeScript

### backend

Backend API на Express.js. Обрабатывает запросы от frontend и взаимодействует с базой данных через Prisma.

Основные технологии:
- Express.js
- Prisma ORM
- PostgreSQL
- TypeScript

### shared

Общий код, который используется как в frontend, так и в backend. Содержит общие типы, интерфейсы и утилиты.

## Работа с монорепозиторием

### Установка и настройка

1. Клонируйте репозиторий:
   ```
   git clone https://github.com/VikaDemkina/TravelBookingMonorepo.git
   cd TravelBookingMonorepo
   ```

2. Установите зависимости:
   ```
   npm install
   ```

3. Настройте .env файлы:
   ```
   cp packages/backend/.env.example packages/backend/.env
   ```

4. Запустите миграции базы данных:
   ```
   cd packages/backend
   npx prisma migrate dev
   ```

### Команды

Все команды выполняются из корня проекта:

- **Разработка**: `npm run dev` - запускает все пакеты в режиме разработки
- **Сборка**: `npm run build` - собирает все пакеты
- **Запуск**: `npm run start` - запускает собранные пакеты
- **Линтинг**: `npm run lint` - проверяет код на соответствие стандартам
- **Тесты**: `npm run test` - запускает тесты для всех пакетов

### Добавление новых пакетов

1. Создайте новую директорию в папке `packages/`:
   ```
   mkdir packages/new-package
   ```

2. Инициализируйте новый пакет:
   ```
   cd packages/new-package
   npm init -y
   ```

3. Обновите `package.json` добавив необходимые скрипты и зависимости.

4. Обновите корневой `turbo.json` при необходимости.

## CI/CD Процессы

### Непрерывная интеграция (CI)

При каждом push в ветку `main` или создании pull request запускается CI процесс, который:

1. Устанавливает зависимости
2. Запускает линтинг
3. Запускает тесты
4. Собирает все пакеты

### Непрерывное развертывание (CD)

При успешном push в ветку `main` (кроме изменений в документации) запускается CD процесс, который:

1. Собирает все пакеты
2. Деплоит приложение в тестовую среду

### Мониторинг метрик

Для анализа эффективности CI/CD процессов собираются метрики, которые можно загрузить из артефактов GitHub Actions. Подробнее о метриках см. [METRICS.md](./METRICS.md).