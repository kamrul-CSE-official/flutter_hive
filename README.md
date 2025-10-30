# 🐝 Flutter Hive Local Storage App

A Flutter application demonstrating efficient local data storage using **Hive**. This app allows users to manage a list of items with persistent storage that survives app restarts.

![Flutter](https://img.shields.io/badge/Flutter-3.19+-02569B?logo=flutter)
![Hive](https://img.shields.io/badge/Hive-2.2.3-FF4088)
![License](https://img.shields.io/badge/License-MIT-green)

---

## ✨ Features

- 🗄️ **Local Database** - Persistent storage using Hive
- ➕ **Add Items** - Dynamic list management with validation
- 📋 **Display Items** - Clean list view in descending order (newest first)
- ✅ **Input Validation** - Prevents empty entries
- 🧹 **Auto-Clear** - Text field clears after successful addition
- 🏗️ **Scalable Architecture** - Ready for multiple input fields

---

## 🖼️ Screenshots

| Add Items | List View |
|-----------|-----------|
| <img src="assets/screenshots/add_item.png" width="300"> | <img src="assets/screenshots/list_view.png" width="300"> |

---

## 🏗️ Project Structure
ib/
├── main.dart # App entry point & Hive initialization
├── screens/
│ └── home_screen.dart # Main screen with input & list view
└── widgets/
└── item_tile.dart # Reusable item display widget


---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.19 or higher)
- Dart (3.3 or higher)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/flutter-hive-storage.git
   cd flutter-hive-storage

2. **Install dependencies**
    ```bash
    flutter pub get

3. **Add Hive dependencies (in pubspec.yaml)**
    ```bash
    dependencies:
  flutter:
    sdk: flutter
  hive: ^2.2.3
  hive_flutter: ^1.1.0


 ## 👨‍💻 Author
 # MD. Kamrul Hasan

🎓 B.Sc in CSE — Port City International University

💻 Passionate Flutter & Full-Stack Developer


📄 License
This project is licensed under the MIT License - see the LICENSE file for details.