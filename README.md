# 🚗 ParkIt – Smart Car Parking System

A full-stack Smart Car Parking application designed to simplify parking slot discovery and reservation through a user-friendly mobile interface.

ParkIt aims to make parking more convenient by allowing users to explore available parking spaces, book slots, and manage their reservations.

## ✨ Features

- 📍 Explore available parking spaces.
- 🅿️ View parking slot information.
- 📅 Book parking slots.
- 📋 Manage and view parking reservations.
- 🔐 User authentication and authorization.
- 📱 User-friendly Flutter mobile interface.
- 🔄 Backend API integration.
- 🗄️ MongoDB database management.

## 🛠️ Tech Stack

### Frontend
- Flutter
- Dart

### Backend
- Node.js
- Express.js
- REST API

### Database
- MongoDB

### Development Tools
- Git & GitHub
- VS Code
- Postman

## 📂 Project Structure

```text
ParkIt/
│
├── frontend/
│   └── parking/
│       ├── lib/
│       ├── android/
│       ├── ios/
│       ├── pubspec.yaml
│       └── ...
│
├── backend/
│   ├── controllers/
│   ├── models/
│   ├── routes/
│   ├── middleware/
│   ├── config/
│   ├── server.js
│   └── package.json
│
├── .gitignore
└── README.md
```

*Note: Adjust the folder structure above to match your actual project files.*

## ⚙️ Installation & Setup

### 1. Clone the Repository

```bash
git clone https://github.com/RahulUbale06/ParkIt-Fullstack.git
cd ParkIt-Fullstack
```

### 2. Backend Setup

Navigate to the backend directory:

```bash
cd backend
npm install
```

Create a `.env` file in the backend directory and configure your environment variables:

```env
PORT=5000
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_secret_key
```

Start the backend server:

```bash
npm start
```

### 3. Frontend Setup

Open another terminal and navigate to the Flutter project:

```bash
cd frontend/parking
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

## 🔐 Environment Variables

The backend requires environment variables for secure configuration.

| Variable | Description |
|---|---|
| PORT | Backend server port |
| MONGO_URI | MongoDB connection string |
| JWT_SECRET | Secret key for JWT authentication |

Never commit your actual `.env` file or expose sensitive credentials.



## 🚀 Future Improvements

- Real-time parking slot availability.
- Online payment integration.
- Google Maps integration.
- Parking history and analytics.
- Push notifications.
- Admin dashboard.

## 👨‍💻 Developer

**Rahul Ubale**

- GitHub: [@RahulUbale06](https://github.com/RahulUbale06)

## 📄 License

This project is developed for educational and learning purposes.

---

⭐ If you find this project interesting, consider giving it a star!