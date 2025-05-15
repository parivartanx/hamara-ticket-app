# 🚀 COPILOT_GUIDELINES.md

> 👨‍💻 This file defines how GitHub Copilot should generate Flutter code using **flutter_riverpod** for state management, **go_router** for navigation, and **dio** for API calls — following clean architecture, best practices, and latest 2025 standards.

---

## 📁 Folder Structure (Feature-First + Clean Architecture)

lib/
├── main.dart # Entry point
├── app.dart # Root widget & GoRouter config
│
├── config/ # App-wide configuration
│ ├── router/ # go_router setup
│ └── theme/ # Theme, text styles, colors
│
├── core/ # Reusable utilities/services
│ ├── services/ # Dio, secure storage, preferences
│ ├── error/ # Error handlers & exceptions
│ ├── constants/ # App-wide constants/enums
│ └── utils/ # Extensions, helpers
│
├── shared/ # Reusable UI widgets
│ ├── widgets/ # Common components
│ └── providers/ # Global providers (app-wide)
│
├── features/ # All app modules/features
│ ├── auth/ # e.g. login, signup, etc.
│ │ ├── data/ # DTOs, repository impl, API
│ │ ├── domain/ # Entity, repository abstract, use cases
│ │ ├── presentation/
│ │ │ ├── pages/
│ │ │ ├── widgets/
│ │ │ └── providers/ # Feature-specific Riverpod providers
│ │ └── auth_module.dart # Barrel file for exports
│ │
│ └── home/
│ └── ... (same pattern)
│
└── l10n/ # Localization (.arb files)

markdown
Copy
Edit

---

## ⚙️ GitHub Copilot Rules

### ✅ Must Follow
- Use `flutter_riverpod` for state management (`ref.watch()`, `StateNotifier`, etc.)
- Use `go_router` for navigation (define routes in `config/router/`)
- Use `dio` for API requests, wrapped in a service layer.
- Follow feature-first folder structure and separation of concerns.
- Apply `null safety`, `required`, `late` correctly.
- Use `AsyncValue` for async UI rendering with Riverpod.
- Class Based Component (Widget)

### ❌ Avoid
- ❌ Using `setState()` — use `StateNotifier` or `AsyncNotifier`.
- ❌ Navigating with `Navigator.push` — use `GoRouter`.
- ❌ Hardcoded strings/colors — use `Theme`, `AppLocalizations`.
- ❌ Global `BuildContext` — prefer `WidgetRef` in Riverpod.
- ❌ Using `print()` — use a logger service instead.
- ❌ Function Component(Widget)

---

## 🧠 Naming Conventions

| Type         | Format         | Example                     |
|--------------|----------------|-----------------------------|
| Class/Widget | `PascalCase`   | `LoginScreen`, `UserModel`  |
| File/Folder  | `snake_case`   | `login_screen.dart`         |
| Variable     | `camelCase`    | `userEmail`                 |
| Constant     | `UPPER_SNAKE`  | `API_TIMEOUT_SECONDS`       |

---

## 🧩 State Management (Riverpod)

- Use `flutter_riverpod` (v3+ with `AsyncNotifier` / `Notifier`)
- Define providers in:
shared/providers/ # Global providers
features/<module>/... # Feature-specific providers

rust
Copy
Edit
- Use `AsyncValue` in UI layer for loading/error/data states.
- Example:
```dart
final userProvider = AsyncNotifierProvider<UserController, User>((ref) {
  return UserController(ref);
});
🔁 Routing (GoRouter)
Define GoRouter routes inside config/router/app_router.dart

Use GoRoute, ShellRoute with typed params.

Navigate using:

dart
Copy
Edit
context.go('/login');
context.pushNamed('profile', pathParameters: {'id': userId});
🌐 API Layer (Dio)
Use dio in core/services/api_service.dart

Create BaseApiService for reuse with interceptors.

Organize all models under features/<module>/data/models/

Use json_serializable or freezed for type safety.

Example:

dart
Copy
Edit
final response = await dio.get('/users');
final user = UserModel.fromJson(response.data);
🔐 Error Handling
Define custom exceptions inside core/error/

Use Either<Failure, Success> or Result<T> patterns in domain layer

Show user-friendly error messages using ref.read(snackBarService) or dialog

🎨 UI Best Practices
Use SafeArea, Scaffold, and theme-aware widgets.

Use LayoutBuilder or flutter_screenutil for responsiveness.

Break UIs into:

widgets/: Reusable view components

pages/: Fullscreen views

providers/: Riverpod logic

📦 Assets & Code Generation
Manage assets via pubspec.yaml

Use flutter_gen for images, colors, fonts

Use:

bash
Copy
Edit
flutter pub run build_runner build --delete-conflicting-outputs
🧪 Testing Guidelines
Follow structure:

bash
Copy
Edit
test/
└── features/
    └── auth/
        ├── presentation/
        └── domain/
Use mocktail, riverpod_test, flutter_test

Prioritize unit tests for usecases, StateNotifiers, and integration

🧰 Recommended Packages (2025 Ready)
Purpose	Package
State Management	flutter_riverpod
API Requests	dio
Navigation	go_router
Code Generation	freezed, json_serializable, build_runner
Storage	shared_preferences, flutter_secure_storage
Responsive UI	flutter_screenutil
Localization	flutter_localizations
Logging	logger
Testing	mocktail, riverpod_test

✅ Summary Checklist
Rule	Status
Feature-first, clean architecture	✅
Riverpod for state management	✅
GoRouter for routing	✅
Dio with clean API abstraction	✅
Modular UI and testable logic	✅
Strict null-safety & best practices	✅