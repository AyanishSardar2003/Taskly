# Taskly 📝

Taskly is a modern **task management Flutter application** designed to help users organize their daily tasks efficiently.  
The app provides a clean and intuitive **UI/UX**, supports **task priorities**, **dark/light themes**, and **multi-language support** using a fully local database.

---

## ✨ Features

- ➕ Add new tasks  
- ✏️ Update existing tasks  
- 🗑️ Delete tasks  
- ⭐ Task priority system:
  - Important
  - Normal
  - Low
- 🗂️ Archive tasks
- 🌙 Dark Mode / ☀️ Light Mode
- 🌍 Multi-language support:
  - English
  - Arabic
- 💾 Local data storage using SQLite (Sqflite)
- ⚡ State management with GetX
- 🎨 Beautiful UI and smooth UX
- 📖 Simple onboarding / tutorial screen for first-time users

---

## 🛠️ Technologies Used

- **Flutter**
- **GetX** (State Management, Routing, Localization)
- **Sqflite** (Local Database)
- **Material Design**
- **Clean & Scalable Project Structure**

---

## 📂 Project Structure

```file structure
lib/
│── getx/
│   ├── local/
│   │   ├── local.dart
│   │   └── controller.dart
│
│── models/
│   └── home_screen/
│       ├── custom_app_bar.dart
│       ├── custom_nav_bar.dart
│       ├── my_task_card.dart
│       └── task_card.dart
│
│── screens/
│   ├── add_task_screen.dart
│   ├── archive_screen.dart
│   ├── details_screen.dart
│   ├── home_screen.dart
│   ├── settings_screen.dart
│   ├── splash_screen.dart
│   └── tutrial_screen.dart
│
│── sql/
│   └── sqldb.dart
│
└── main.dart
