# Seventify - Spotify Clone

Seventify is a music streaming app developed using Flutter, designed to replicate key features of Spotify such as music playback, search, playlist creation, and recommendations. This README provides the necessary steps to access, clone, and modify the project.

## Table of Contents
- [Installation](#installation)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Building APK](#building-apk)
## Installation

To get started with Seventify, you'll need to clone the GitHub repository and set up the project locally.

### Step 1: Clone the Repository
Clone the project to your local machine by running the following command in your terminal:

```bash
git clone https://github.com/gideonladiyo/Spotify_Clone_Kelompok7_PPB
```

### Step 2: Install Dependencies
Navigate to the project directory and run the following command to install the necessary dependencies:

```bash
cd seventify
flutter pub get
```

### Step 3: Set up API Key
For accessing music-related data, you'll need a valid API key. Follow the instructions below to set up your API key:
- Register for an API key from [Spotify Developer Dashboard](https://developer.spotify.com/dashboard/applications).
- Create project and set `myapp://spotify-kelompok7/callback` for the Redirect URI.
- Once you have the client ID and client secret, navigate to the `lib/design_system/constant/` directory and update the `string.dart` file with your API credentials.

```dart
class CustomStrings {
  static const String clientId = 'your client id';
  static const String clientSecret = 'your client secret';
}
```

## Getting Started

Once the setup is complete, you can run the app on an emulator or a physical device.

```bash
flutter run
```

This will launch the Seventify app. You can now start exploring, playing music, creating playlists, and more!

## Project Structure

The project is organized as follows:

```
lib/
├── controllers/          # GetX controllers for state management
├── data/                 # Data models for API responses, API requests and data handling, Page routes for navigation
├── presentation/         # Screens and UI elements for the app
└── design-system/        # Reusable widgets and styles
```

## Building APK
To build the APK for Seventify, follow these steps:

### Step 1: Set up an Android Device or Emulator
Ensure that you have an Android device connected or an emulator running.

### Step 2: Build the APK
In your terminal, navigate to the project directory and run the following command to build the APK:
```
flutter build apk -- release
```
### Step 3: Locate the APK
After the build process completes, you can find the APK in the following directory:
```
build/app/outputs/flutter-apk/app-release.apk
```
You can now install the APK on your Android device for testing or distribution.