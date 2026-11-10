# Flutter beginner guide (this project)

This document explains **Flutter basics** and how **this course booking app** is organized. You do not need prior mobile experience to follow along.

Official docs: [https://docs.flutter.dev/](https://docs.flutter.dev/)

---

## What is Flutter?

Flutter is Google’s UI toolkit for building apps from **one codebase** for:

- Android
- iOS
- Web
- Windows / macOS / Linux

You write **Dart** code. Flutter draws the UI with its own engine (not native Android/XML or iOS Storyboards for layout).

---

## Before you start

1. Install the **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install)
2. Install **Android Studio** or **VS Code** with the Flutter extension
3. Check your setup:

```bash
flutter doctor
```

Fix anything marked with an error (Android SDK, licenses, etc.).

4. From this project folder:

```bash
cd /path/to/registration_app
flutter pub get
flutter run
```

Pick a device: phone emulator, Chrome (`flutter run -d chrome`), or a USB-connected phone.

### Useful commands

| Command | What it does |
|--------|----------------|
| `flutter pub get` | Download packages listed in `pubspec.yaml` |
| `flutter run` | Build and launch the app |
| `flutter analyze` | Check code for errors and style issues |
| `flutter test` | Run automated tests |
| `r` in terminal | **Hot reload** — apply code changes quickly while app is running |
| `R` in terminal | **Hot restart** — full restart of the app |

This app needs **internet** for course images and APIs.

---

## How a Flutter app starts

Every app has an entry point:

```dart
void main() {
  runApp(const RegistrationApp());
}
```

File: [`lib/main.dart`](lib/main.dart)

`RegistrationApp` is a **widget** that configures:

- App title and theme
- **First screen**: `HomePage`

**Navigation** to other screens uses `Navigator.push` (go forward) and `Navigator.pop` (go back).

---

## Core ideas (beginner)

### 1. Everything is a widget

Buttons, text, padding, and whole screens are **widgets**. You compose small widgets into larger ones.

Examples in this project:

- `Text('Book Course')` — shows text
- `ElevatedButton` — button
- `Scaffold` — screen layout (app bar + body)
- `FutureBuilder` — shows loading/data/error while waiting on async work

### 2. Stateless vs Stateful widgets

| Type | When to use |
|------|-------------|
| **StatelessWidget** | UI that does not change by itself (e.g. `ThankYouPage` with fixed props) |
| **StatefulWidget** | UI that changes: forms, selected course, loading flags |

Stateful widgets have a `State` class. Call **`setState(() { ... })`** to rebuild the UI after data changes.

Examples: [`lib/pages/home_page.dart`](lib/pages/home_page.dart), [`lib/pages/register_page.dart`](lib/pages/register_page.dart).

### 3. Async work (API calls)

Network calls take time. Use **`Future`** and:

- `async` / `await` in functions, or
- **`FutureBuilder`** in the UI (used on home and register pages)

Pattern in services:

```dart
final response = await http.get(uri);
// parse JSON, return models or throw ApiException
```

### 4. Packages (dependencies)

Third-party code is listed in [`pubspec.yaml`](pubspec.yaml). This app uses:

- `http` — REST API calls

After editing `pubspec.yaml`, run `flutter pub get`.

---

## This project’s folder structure

```text
lib/
  main.dart                 # App entry, theme, home route
  config/
    api_config.dart         # API base URLs (change backend here)
  models/
    course.dart             # Data shapes (Course, BannerItem, etc.)
    banner_item.dart
    registration_payload.dart
  services/
    course_api_service.dart       # GET products / banners
    registration_api_service.dart # POST registration
    api_exception.dart
  pages/
    home_page.dart          # Banners + about + Book Course
    register_page.dart      # Course slider + form + submit
    thank_you_page.dart     # Success screen
  widgets/
    home_banner_carousel.dart
    selectable_course_carousel.dart
    horizontal_carousel_scroll_behavior.dart
```

**Rule of thumb:**

- **pages** — one screen each
- **widgets** — reusable UI pieces
- **models** — data from JSON
- **services** — talk to APIs (no UI)
- **config** — URLs and constants

---

## User flow in this app

```text
HomePage
  → loads 2 banners from Fake Store API (via CourseApiService)
  → user taps "Book Course"

RegisterPage
  → loads all products as courses
  → user swipes slider, picks one, enters name + mobile
  → RegistrationApiService POSTs to JSONPlaceholder (demo)
  → on success → ThankYouPage
```

API URLs: [`lib/config/api_config.dart`](lib/config/api_config.dart)

| Action | Demo endpoint |
|--------|----------------|
| List courses | `GET https://fakestoreapi.com/products` |
| Submit booking | `POST https://jsonplaceholder.typicode.com/posts` |

To use **your** server later, change `ApiConfig` and adjust `Course.fromJson()` if JSON fields differ.

---

## Common beginner tasks

### Change API URL

Edit [`lib/config/api_config.dart`](lib/config/api_config.dart) and restart the app (`R`).

### Add a form field

1. Add a `TextEditingController` in `RegisterPage` state
2. Add a `TextFormField` in the `Form`
3. Add validation in `validator:`
4. Include the value in `RegistrationPayload` and `toJson()`
5. `dispose()` the controller in `dispose()`

### Add a new screen

1. Create `lib/pages/my_page.dart` as a `StatelessWidget` or `StatefulWidget`
2. Navigate: `Navigator.push(context, MaterialPageRoute(builder: (_) => const MyPage()))`

### Fix “Unable to load courses”

- Check internet on device/emulator
- Android release builds need `INTERNET` in `AndroidManifest.xml` (already set in this project)
- Web: your API must allow CORS from the browser

---

## Widgets used in this app (cheat sheet)

| Widget | Purpose here |
|--------|----------------|
| `Scaffold` | Screen shell + `AppBar` |
| `SingleChildScrollView` | Scroll when content is tall (form section) |
| `Column` / `Row` | Vertical / horizontal layout |
| `FutureBuilder` | Show spinner or data after API fetch |
| `PageView` | Banner and course carousels |
| `Form` + `TextFormField` | Validated inputs |
| `Card` | Course tiles |

---

## Debugging tips

1. Read **red error text** in the terminal or debug console first
2. Use `flutter analyze lib/` for static checks
3. If UI looks wrong after layout changes, try **hot restart** (`R`)
4. `print('debug: $value');` — remove before production, or use `debugPrint`

---

## Next steps to learn Flutter

1. [Dart language tour](https://dart.dev/guides/language/language-tour)
2. [Widget catalog](https://docs.flutter.dev/ui/widgets)
3. [State management intro](https://docs.flutter.dev/data-and-backend/state-mgmt/intro) (this app uses `setState` only — good for beginners)
4. [Networking / HTTP](https://docs.flutter.dev/cookbook/networking/fetch-data)

---

## Glossary

| Term | Meaning |
|------|---------|
| **Dart** | Programming language for Flutter |
| **Widget** | UI building block |
| **Hot reload** | Fast refresh while developing |
| **pubspec.yaml** | App name, version, dependencies |
| **Material** | Google’s design widgets (`MaterialApp`, etc.) |
| **JSON** | Data format from most REST APIs |
| **Future** | Represents work that completes later (e.g. HTTP) |

---

## Questions about this repo?

Start reading from [`lib/main.dart`](lib/main.dart) → [`lib/pages/home_page.dart`](lib/pages/home_page.dart) → [`lib/services/course_api_service.dart`](lib/services/course_api_service.dart). That follows the same path as the running app.
