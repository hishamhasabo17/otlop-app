# Otlop

A Flutter food and drinks ordering app (coffee, cakes, donuts) built as a **practice project while following a course**.

> Label: Practice (course project). The backend API is a ready-made API provided with the course, not built by me.

## Features
- Sign up and login with form validation
- Home screen: categories, brands and popular items
- Explore, Cart and My Orders tabs with a bottom navigation bar
- Loading, success and error states with snackbars

## Tech
- Flutter and Dart
- State management: Bloc / Cubit (flutter_bloc)
- REST API calls through a data source class (`AuthDataSource`)
- SVG assets (flutter_svg)

## Screenshots
Add your screenshots here, for example:

| Home | Login | Sign up |
|------|-------|---------|
| ![Home](screenshots/home.png) | ![Login](screenshots/login.png) | ![Signup](screenshots/signup.png) |

## Run it
```bash
flutter pub get
flutter run
```

## What I learned
- Structuring a Flutter app with Cubits and data sources
- Form validation and handling API loading and error states
- Building multi-screen navigation with a bottom bar
