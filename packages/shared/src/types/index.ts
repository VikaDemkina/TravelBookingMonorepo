// Общие типы для всех пакетов

export interface ITour {
  id: string;
  createdIdBy: string;
  title: string;
  createdDate: Date;
  description?: string;
  image: string;
}

export interface IUser {
  id: string;
  firstName: string;
  lastName: string;
  patronymic?: string;
  email: string;
  role: 'ADMIN' | 'CLIENT';
}

export interface IBooking {
  tourId: string;
  userId: string;
  numberOfPeople: number;
  specialRequests?: string;
}