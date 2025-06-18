# 🧠 Autism Support App

A Flutter mobile application to assist autistic children through interactive games while also empowering parents with educational resources and doctor appointments. The app supports Arabic and English and is designed for offline use with a smooth and simple user interface.

---

## 📱 Features

### 👧 Child Section
- 🎮 Five engaging games:
  1. Voice Repetition Game (listen and repeat)
  2. Facial Expression Matching (using camera)
  3. Shape and Color Matching
  4. Image-to-Word Matching
  5. Memory Game
- 🖼️ Voice + image-based learning
- 🗣️ Audio feedback & recognition

### 👨‍👩‍👧 Parent Section
- 📊 Monitor child’s progress
- 📚 Read awareness articles about autism
- 🩺 Reserve doctor appointments via app

---

## 📸 Screenshots

### 🎙️ Voice Repetition Game

| Main Screen | Interaction Screen |
|-------------|--------------------|
| ![Voice Main](https://github.com/yourusername/assets/screenshots/voice_main.png) | ![Voice Play](https://github.com/yourusername/assets/screenshots/voice_play.png) |

### 😃 Facial Expression Matching Game

| Main Screen | Camera Detection Screen |
|-------------|-------------------------|
| ![Face Main](https://github.com/yourusername/assets/screenshots/face_main.png) | ![Face Match](https://github.com/yourusername/assets/screenshots/face_detect.png) |

### 🩺 Doctor Reservation

| Reservation Home | Booking Confirmation |
|------------------|----------------------|
| ![Doctor Home](https://github.com/yourusername/assets/screenshots/doctor_home.png) | ![Doctor Confirm](https://github.com/yourusername/assets/screenshots/doctor_confirm.png) |

### 📚 Awareness Articles

| Article List | Article Details |
|--------------|-----------------|
| ![Article List](https://github.com/yourusername/assets/screenshots/articles_list.png) | ![Article View](https://github.com/yourusername/assets/screenshots/article_view.png) |

### 🖼️ Full App Design

This image shows the overall design of the entire app including both child and parent sections:

![App Design](https://github.com/yourusername/assets/screenshots/full_design.png)

> 📝 Replace the link with your actual image URL if hosted on GitHub or Imgur.

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK
- Dart
- Android Studio / VS Code
- A real device or emulator

### 🧪 Installation

```bash
git clone https://github.com/yourusername/autism-support-app.git
cd autism-support-app
flutter pub get
flutter run
```

---

## 🛠️ Built With

- Flutter
- Dart
- Google ML Kit (Face detection, Voice comparison)
- Lottie (Animations)
- Shared Preferences (Local storage)
- Speech-to-Text / Text-to-Speech

---

## 📁 Folder Structure

```bash
/lib
  ├── main.dart
  ├── screens/
  │   ├── child/
  │   │   ├── voice_game.dart
  │   │   ├── face_game.dart
  │   │   ├── shape_color_game.dart
  │   │   ├── image_word_game.dart
  │   │   ├── memory_game.dart
  │   ├── parent/
  │   │   ├── dashboard.dart
  │   │   ├── reservation.dart
  │   │   ├── articles.dart
  ├── models/
  ├── services/
  ├── widgets/
  └── utils/
```

---

## 🧠 How It Works

- The child selects a game with audio + image prompt
- Voice is recorded and compared with the correct word
- Face recognition game uses camera to match expressions
- Parents can review game scores, read awareness articles, and book medical appointments

---

## 🔮 Future Plans

- Add Arabic voice recognition improvements
- Cloud sync via Google Drive
- In-app parent forums & chat
- Real-time notifications/reminders

---

## 👨‍💻 Developer

**Bashar Taha**  
Flutter Mobile Developer  
[GitHub](https://github.com/yourusername)

---

## 📄 License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file.
