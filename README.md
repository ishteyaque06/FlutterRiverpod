# Flutter Riverpod Architecture & Patterns POC 🚀

A Proof of Concept (POC) demonstrating production-ready state management using **Riverpod**, clean architecture principles, design patterns, and native platform integration in Flutter.

---

### 🏗️ Key Features & Architectural Highlights

This repository serves as a practical showcase for several core Flutter and software engineering concepts:

- **State Management (Riverpod):** Clean UI-to-state separation using view models and specialized providers (e.g., video player state, user preferences).
- **Design Patterns:** Pragmatic implementation of Creational Patterns like the **Factory Pattern** for modular component instantiation.
- **Native Platform Integration:** Custom `native_ui` module demonstrating seamless bridge communication between Flutter and native platforms.
- **Robust Error Handling:** Structured error boundary handling using dedicated core failure models.
- **Theme & Palette Management:** Centralized design system configuration with custom themes and color palettes.

---

### 📂 Project Structure

```text
lib/
├── core/                       # Shared core utilities, configurations, and state
│   ├── failure/                # Global failure and error handling models
│   ├── repository/             # Core repository declarations
│   ├── user_preferences/       # Local storage & user settings providers
│   ├── video_player_provider/  # Custom Riverpod providers for video handling
│   ├── pallete.dart            # Design system color definitions
│   └── theme.dart              # App-wide light/dark themes
├── factoryPattern/             # Implementation of Factory Creational Pattern
├── model/                      # Data models and entities
├── native_ui/                  # Platform-specific UI wrappers & platform channels
├── presentation/               # UI Layer
│   ├── home/                   # Home screen module
│   ├── viewmodel/              # State presentation logic & Riverpod Notifiers
│   └── signup_page.dart        # Authentication/Signup screen
├── widgets/                    # Reusable custom UI components
└── main.dart                   # Application entry point with ProviderScope
