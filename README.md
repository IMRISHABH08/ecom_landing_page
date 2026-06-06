# 📱 FlickTV — Landing Page

A Flutter assignment implementing a rich animated ecommerce landing page.

---

## ✨ Features

- **Architecture**: Clean Architecture
- **State Management**: `ChangeNotifier` + `ListenableBuilder` (no external package)
- **Dependency Injection**: Hand-rolled `ServiceLocator` with `late final` lazy singletons
- **Asset Management**: Spider 
- **Animations**: — `AnimationController`, `TweenSequence`, `CustomPainter`, `StaggeredAnimation`
- **Confetti**: Lottie

---

## 🏗️ Project Structure

```
lib/
├── core/
│   └── di/
│       └── service_locator.dart
├── features/
│   └── landing/
│       ├── data/
│       │   ├── model/
│       │   │   ├── feature_card_model.dart
│       │   │   └── landing_config_model.dart
│       │   └── repository_impl/
│       │       └── landing_repository_impl.dart
│       ├── domain/
│       │   ├── entity/
│       │   │   ├── feature_card.dart
│       │   │   └── landing_config.dart
│       │   ├── repository/
│       │   │   └── landing_repository.dart
│       │   └── usecase/
│       │       └── get_landing_config.dart
│       └── presentation/
│           ├── notifier/
│           │   ├── landing_notifier.dart
│           │   └── landing_state.dart
│           ├── sections/
│           │   ├── cta_section.dart
│           │   ├── feature_cards_section.dart
│           │   └── marquee_section.dart
│           ├── widgets/
│           │   ├── confetti_overlay.dart
│           │   ├── dot_texture_painter.dart
│           │   └── feature_card_widget.dart
│           └── landing_page.dart
├── global/
│   ├── animations/
│   │   ├── bounce_animation.dart
│   │   ├── marquee_animation.dart
│   │   └── staggered_animation.dart
│   └── design_system/
│       ├── app_colors.dart
│       ├── app_spacing.dart
│       └── app_typography.dart
├── resources/
│   ├── images.dart
│   ├── lotties.dart
│   └── resources.dart
└── main.dart
```

---

## 📦 Packages

| Package | Type | Purpose |
|---------|------|---------|
| `lottie` | runtime | Confetti animation |
| `google_fonts` | runtime | Typography (Inter) |
| `font_awesome_flutter` | runtime | Feature card icons |
| `spider` | dev | Asset constant generation |

> No state management, DI, or network packages used.

---



**Bundle ID:** `flicktv.rishabh`  
**App Name:** `Rishabh Gupta Yocket`
