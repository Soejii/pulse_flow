# Focus Pulse

So first of all this started as a project assignment from my Cognitive Psychology class, i hard carried my group with this "game" because i dont think anyone else has the knowledge or competencies to make a digital game in my class (or faculty if im being honest).

This project went through three different iterations.  
The first one came with a bunch of revisions and major game design changes.  
The second one was where my group thought I was wrong, which I highly doubt.  
The third one is this final version.

Huge shoutout to Dini for actually sticking with the project, unlike the other members who i do not think had any clue how my progress was going. Big thanks to everyone who play tested the game, gave feedback, and helped with bug hunting.

The game itself by no means are perfect, there's a lot of language inconsistencies in it (mainly in the instruction) ,and probably other bugs that we did not catch during our play testing time. This is also my first real "vibe coded" project, i used chatgpt 5.2 for almost everything (maybe about 80% idk) and just giving it references (and bug fixing his ass too), i surely hopes that this game is enough for me to get an A because it would sucks ass if i dont get A.

There's still a lot to improve, mainly about the separation of concern in this project's architecture, different tempo for different session, and tightening the range of greenCount per level (ngl im too lazy to do allat).
## What is Focus Pulse

Focus Pulse is a simple cognitive control task inspired by attention and working memory paradigms. Players are asked to memorize the order of green tiles while ignoring distractor tiles, then recall the correct sequence. Difficulty increases across levels and sessions, creating pressure on selective attention and short term memory.

## Technical Overview

### Tech Stack
- Flutter (single codebase)
- GetX for state management, routing, and localization
- SharedPreferences for local persistence
- just_audio for background music and sound effects
- Flutter Web and Android support

### Platform Support

- Web (Chrome desktop and mobile)
- Android (primary debugging and testing platform)

The project was mainly developed and debugged on Android, with Flutter Web used for deployment and sharing.
### Architecture

- Controller driven architecture using GetX
- Separation between UI, controllers, and services
- Persistent state for progress, history, audio settings, and language
- Local history logging per session for later analysis and visualization

### Core Features

- Multi level and multi session gameplay
- Progress tracking with unlocked levels and sessions
- History logging with performance summaries and struggle hotspots
- Audio system with music and SFX toggles
- Bilingual support (Indonesian and English)
- Responsive layout for mobile and desktop browsers

### State and Persistence

- Progress state stores current level, session, and first time flags
- History state stores per session runs including result and recall ratio
- Settings state stores audio and language preferences
- All data is stored locally on device or browser storage

## Installation and Running the Project

### Prerequisites

Make sure you have the following installed:
- Flutter SDK  
  https://docs.flutter.dev/get-started/install
- Android Studio or Android SDK (for Android builds)
- Google Chrome (for web builds)

Optional but recommended:
- FVM (Flutter Version Manager) to lock Flutter versions per project

### Clone the Repository

```bash
git clone https://github.com/Soejii/pulse_flow.git
cd pulse_flow
```
### Install Dependencies

```bash
flutter pub get
```
### Verify Environment

Check if Flutter is set up correctly:
```bash
flutter doctor
```
Make sure there are no critical errors, especially for Android or Chrome.
## Running on Android
### Using a Physical Device
1. Enable Developer Options on your Android phone
2. Enable USB Debugging
3. Connect the device via USB
4. Verify the device is detected:
```bash
flutter devices
```
5. Run the app:
```bash
flutter run
```
### Using Android Emulator

1. Open Android Studio
2. Create and start an Android emulator
3. Run:
```bash
flutter run
```
The app will hot reload by default during development.
## Running on Web

### Debug Mode

```bash
flutter run -d chrome
```
This launches the app in Chrome with hot reload enabled.
### Release Build

```bash
flutter build web --release
```
### Deploying to GitHub Pages

If deploying under a subpath such as GitHub Pages:
```bash
flutter build web --release --base-href "/pulse_flow/"
```
Then upload the contents of:
```bash
build/web
```
to the GitHub Pages branch or folder.
## Play the Game

Web version:  
https://soejii.github.io/pulse_flow/
Android:  
Run locally using Flutter on a physical device or emulator. There is no Play Store release at the moment.
## Notes

This project was built under academic constraints and time pressure. Expect rough edges. The goal was not perfection, but to turn a cognitive psychology concept into a playable and testable digital task. If someone else stumble upon this in the future, feel free to fork it, clone it, change it, or better—improve it. 