# Musync App Changelog

## Version 1.0 - August 2023

### New Features

- **Seamless Device Switching:** Users can now switch between devices without any interruptions, allowing them to start listening to a song on one device and continue on another seamlessly.

- **User Authentication:** Users can create accounts or log in using their Google account credentials to access the app.

- **Music Search and Playback:** Users can search for songs, albums, and artists and play them directly within the app.

- **Offline Playback:** Users can access and play locally stored songs on their device even without an internet connection.

- **Online Playback:** Stream songs stored on Google Drive or the Musync file hosting server when connected to the internet.

- **Sharing:** Users can share their playlists with others directly within the app.

- **Cross-Platform Functionality:** Musync is now available on both web and mobile platforms, allowing users to switch seamlessly between them.

- **Biometric Login:** Added support for fingerprint sensor for enhanced security during login.

- **Light Sensor Integration:** Utilized the light sensor to enable a unique music playback control feature - dimming the screen to pause and brightening to resume.

### Enhancements

- **MVVM Design Pattern:** Implemented the MVVM (Model-View-ViewModel) design pattern for more efficient code reuse and maintenance.

- **BLoC State Management:** Utilized Business Logic Component (BLoC) for robust state management, enabling responsive handling of various app states.

- **API Integration:** Integrated third-party APIs, including Google Login API for seamless user access, a customized Node.js server API for data storage, and Socket.io for data sharing between app instances.

- **Data Storage Optimization:** Implemented effective data storage strategies, including maintaining music paths from the user's device and uploading music files to the Node.js server, enabling seamless cross-device access.

- **Security Measures:** Implemented multiple security layers, including API security and user authorization, using a custom Node.js server and MongoDB for database management.

### Known Issues

- **Bug 1:** Slow music loading: Occasional delays in loading music, especially on slower devices.

- **Bug 2:** Music Deletion not working: Users may experience issues when trying to delete songs from their library.

- **Bug 3:** NowPlay screen is buggy: In some instances, the Now Playing screen may exhibit unexpected behavior.

- **Bug 4:** Randomizer doesn't work: The random playback feature may not function as expected.

For more details, refer to the [GitHub Repository](https://github.com/AlexxyQQ/Musync).
