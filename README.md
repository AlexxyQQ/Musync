# Musync - Seamless Music Streaming App

| Platform | Supported          |
| -------- | ------------------ |
| Android  | :white_check_mark: |
| IOS      | :x:                |
| Web      | :x:                |
| Windows  | :x:                |
| Linux    | :x:                |

Musync is a comprehensive music streaming application designed to provide users with an exceptional music listening experience. This app allows users to seamlessly switch between devices, access their own music library both online and offline, and enjoy music without interruptions. Whether you're at home or on the go, Musync ensures that your favorite songs are just a tap away.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Usage](#usage)
- [Known Issues](#known-issues)
- [Todo Features](#todo-features)
- [Contributing](#contributing)
- [License](#license)

## Introduction

Musync is a music streaming application that aims to enhance the user experience of locally stored music. While existing music streaming apps often require a stable internet connection, Musync allows you to listen to your favorite songs even without internet connectivity. Seamlessly switch between devices and platforms to enjoy your music collection wherever you are.

## Features

- **Seamless Device Switching:** Switch between devices without any interruptions, ensuring a continuous listening experience.
- **User Authentication:** Create an account or log in using your Google account credentials for secure access to the app.
- **Music Search and Playback:** Search for songs, albums, and artists, and play them directly within the app.
- **Offline Playback:** Access and play locally stored songs on your device, even without an internet connection.
- **Online Playback:** Stream songs stored on Google Drive or the Musync file hosting server when connected to the internet.
- **Sharing:** Share your playlists with others directly within the app.
- **Cross-Platform Functionality:** Musync is available on both web and mobile platforms, allowing seamless switching.
- **Biometric Login:** Enhance security with fingerprint sensor support during login.
- **Light Sensor Integration:** Control music playback using the light sensor—dim the screen to pause and brighten to resume.
- **Playlist Management (Todo Feature):** Organize, create, and manage personalized playlists.
- **Continuation from Timestamp (Todo Feature):** Resume playback from the exact timestamp where you left off.
- **Major UI Overhaul (Todo Feature):** Enjoy an improved user interface with a modern design.
- **Forgot Password (Todo Feature):** Recover forgotten passwords through a password recovery mechanism.
- **Integration of YouTube (Todo Feature):** Discover and play music videos directly within the app.
- **Downloading of Songs (Todo Feature):** Download songs for offline listening.
- **Notification of Currently Playing Song (Todo Feature):** Get notifications for the currently playing song.
- **Music Recommendation (Todo Feature):** Receive personalized music recommendations based on your preferences.
- **Personalized Playlist Recommendation (Todo Feature):** Get recommendations for personalized playlists.

## Getting Started

### Prerequisites

- Flutter and Dart SDK (compatible versions specified in the `pubspec.yaml` file)
- Android Studio or Xcode for mobile development

### Installation

1. Clone this repository: `git clone https://github.com/AlexxyQQ/Musync.git`
2. Clone the API repository : `git clone https://github.com/AlexxyQQ/Musync-API.git`
3. Install Flutter dependencies: `flutter pub get`
4. Install API dependencies: `npm install`
5. Run the API server: `npm start` or `npm run dev`
6. Run the Flutter app: `flutter run`

## Usage

1. Launch the Musync app on your preferred platform.
2. Create an account or log in using your Google account.
3. Explore the app's features, search and play music, and enjoy the seamless device switching.

## Known Issues

- **Bug 1:** Slow music loading: Occasional delays in loading music, especially on slower devices.
- **Bug 2:** Music Deletion not working: Users may experience issues when trying to delete songs from their library.
- **Bug 3:** NowPlay screen is buggy: In some instances, the Now Playing screen may exhibit unexpected behavior.
- **Bug 4:** Randomizer doesn't work: The random playback feature may not function as expected.

## Todo Features

- **Playlist Management**: Allow users to create, modify, and organize their playlists for a more personalized music experience.

- **Continuation from Timestamp**: Implement the ability to resume playback from the exact timestamp where the user left off.

- **Major UI Overhaul**: Enhance the user interface with a significant design update for improved aesthetics and usability.

- **Forgot Password**: Add a password recovery mechanism for users who forget their passwords.

- **Integration of YouTube**: Integrate YouTube API to allow users to discover and play music videos directly within the app.

- **Downloading of Songs**: Enable users to download songs for offline listening.

- **Notification of Currently Playing Song**: Implement notifications that display the currently playing song for easy reference.

- **Music Recommendation**: Provide personalized music recommendations based on user preferences and listening history.

- **Personalized Playlist Recommendation**: Offer recommendations for personalized playlists curated to the user's taste.

## Contributing

Contributions are welcome! If you find any issues or want to enhance the app, please open a pull request. For major changes, please discuss the proposed changes first.

## License

---
