## 🏠 Flutter Internship Assignment — Hotspot Host Onboarding Questionnaire

This Flutter project is built as part of the **Hotspot Host Onboarding Assignment**.
The app helps screen and onboard potential hotspot hosts by collecting their preferences, written answers, and recorded responses (audio/video).

---

### 📋 Overview

Hotspot hosts are individuals who facilitate and manage community events called hotspots.
This onboarding app helps the platform assess applicants’ suitability by collecting their responses through a structured questionnaire.

---

## 🚀 Features Implemented

### 🧬 **1. Experience Type Selection Screen**

* Fetches experiences from the provided API:
  `https://staging.chamberofsecrets.8club.co/v1/experiences?active=true`
* Displays each experience card using `image_url` as the background.
* **Grayscale unselected state** and **colored selected state**.
* Supports **multiple selections**.
* Multi-line text field with **250-character limit** for user input.
* Maintains selected experience IDs and text in the state.
* On pressing **Next**, logs the state and navigates to the next screen.

### 🎤 **2. Onboarding Question Screen**

* Multi-line text field with **600-character limit**.
* Supports **audio recording** with:

  * Real-time **waveform visualization** 🎵
  * **Cancel** option while recording.
  * **Delete** recorded audio.
* Supports **video recording** with:

  * Option to delete recorded video.
* Automatically hides record buttons when corresponding media is already recorded.
* Smooth **UI transitions** and responsive layout when the keyboard opens.

---

## 🌟 Brownie Points Implemented

✅ Pixel-perfect design (based on the provided Figma file).
✅ Smooth UI responsiveness for keyboard interactions.
✅ Used **BLoC** for state management.
✅ API calls handled using **Dio**.
✅ Added **animations**:

* Experience card slide-in on selection.
* Next button width animation when record buttons disappear.
  ✅ Well-structured codebase with clear separation of screens, models, and services.

---

## 🧠 Tech Stack

* **Framework:** Flutter
* **State Management:** BLoC
* **Networking:** Dio
* **Permissions:** permission_handler
* **Audio Recording:** record
* **Video Recording:** camera / video_player
* **UI:** Material + Custom Animations
* **Prototype:** https://drive.google.com/file/d/1qwhR9OUMKwEp5TCiN0HToYBmcCpbQrQv/view?usp=sharing

## 👨‍💻 Author

**Riddesh Kankariya**
Flutter Developer Intern
📧 riddeshkankariya@gmail.com
