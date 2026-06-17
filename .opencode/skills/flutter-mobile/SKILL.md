---
name: flutter-mobile
description: Expert Flutter/Dart mobile development with state management, clean architecture, platform integration, and production deployment
metadata:
  languages: dart
  frameworks: flutter
  platforms: android,ios,web
---

## What I do

I build production-grade Flutter applications with clean architecture and modern patterns:

- **Clean Architecture**: Feature-first structure with domain/data/presentation layers
- **State Management**: Riverpod (preferred), Bloc/Cubit, GetX, Provider
- **Routing**: go_router with deep linking, shell routes, redirect guards
- **Networking**: dio with interceptors, retry, timeout, typed responses
- **Local Storage**: drift (SQLite), hive, shared_preferences, flutter_secure_storage
- **Code Generation**: freezed (immutable models), json_serializable, build_runner
- **Testing**: Unit tests, widget tests, integration tests, golden tests
- **Platform Integration**: Platform channels, method channel, pigeon
- **CI/CD**: Codemagic, Bitrise, GitHub Actions for Flutter
- **Flavors**: Environment-based configuration (dev, staging, prod)

## When to use me

- Building new Flutter apps from scratch
- Implementing state management solutions
- Designing navigation with go_router
- Creating platform-specific integrations (camera, GPS, notifications)
- Writing integration and widget tests
- Setting up Flutter CI/CD pipelines
- Migrating between state management solutions
- Optimizing Flutter app performance

## Best Practices

### Architecture
- Use feature-first folder structure
- Separate domain (entities, use cases), data (repositories, data sources), and presentation (pages, widgets)
- Depend on abstractions (interfaces) not implementations
- Use injectable or get_it for dependency injection
- Keep widgets small and composable

### State Management
- Prefer Riverpod for new projects (compile-safe, testable)
- Use `StateNotifier` or `AsyncNotifier` for complex state
- Avoid business logic in widgets
- Use `select` to minimize rebuilds
- Handle loading, error, and data states explicitly

### Code Quality
- Use `dart analyze` with strict analysis options
- Enable `strict-casts: true` and `strict-raw-types: true`
- Use `freezed` for immutable data classes
- Use `json_serializable` with `@JsonSerializable`
- Run `build_runner` as part of CI

### Testing
- Widget tests for UI components with `pumpWidget`
- Integration tests for critical user flows
- Use `mockito` or `mocktail` for mocking
- Golden tests for visual regression
- Test accessibility with `Semantics`

### Performance
- Use `const` constructors everywhere possible
- Implement lazy loading for lists with `ListView.builder`
- Use `RepaintBoundary` for complex animations
- Profile with Flutter DevTools
- Minimize widget rebuilds with keys and select

## Project Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart                 # MaterialApp.router
│   ├── router.dart              # go_router config
│   └── theme/
│       ├── app_theme.dart
│       └── app_colors.dart
├── core/
│   ├── constants/
│   ├── exceptions/
│   ├── network/
│   │   ├── api_client.dart      # Dio instance
│   │   └── interceptors/
│   ├── utils/
│   └── widgets/                 # Shared widgets
├── features/
│   ├── auth/
│   │   ├── data/
│   │   │   ├── repositories/
│   │   │   └── datasources/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/    # Abstract interfaces
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── providers/       # Riverpod providers
│   │       └── widgets/
│   └── home/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── generated/                   # Generated code
test/
├── unit/
├── widget/
├── integration/
└── fixtures/
android/
ios/
web/
pubspec.yaml
analysis_options.yaml
```
