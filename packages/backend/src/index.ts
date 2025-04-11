import express from 'express';
import cors from 'cors';
import { config } from 'dotenv';

// Загрузка переменных окружения
config();

const app = express();
const port = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

// Простой эндпоинт для проверки работоспособности
app.get('/api/health', (req, res) => {
  res.json({ status: 'ok' });
});

// Основные маршруты API будут добавлены позже

app.listen(port, () => {
  console.log(`Backend API running on port ${port}`);
});