# BardBeats

<div align="center">
  <img src="assets/logo/logo.png" width="300"/>
  <div>&nbsp;</div>
  <div align="center">
    <b><font size="5">BardBeats Dashboard</font></b>
    <sup>
      <a href="https://bardbeats.web.app/#/login">
        <i><font size="4">Check it out!</font></i>
      </a>
    </sup>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <b><font size="5">BardBeats Docs</font></b>
    <sup>
      <a href="your-docs-url">
        <i><font size="4">Read the docs</font></i>
      </a>
    </sup>
  </div>
  <div>&nbsp;</div>

[![docs](https://img.shields.io/badge/docs-latest-blue)](https://your-docs-url)
[![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)
![Flutter Version](https://img.shields.io/badge/flutter-v3.10.0-blue)
![Dart Version](https://img.shields.io/badge/dart-v3.0.0-blue)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

</div>

## Table of Contents

- [BardBeats](#bardbeats)
  - [Table of Contents](#table-of-contents)
  - [Getting Started 🚀](#getting-started-)
    - [Installation](#installation)
  - [Handling Environment Variables](#handling-environment-variables)
    - [In .env file](#in-env-file)
  - [Technical Overview](#technical-overview)
  - [Core Libraries](#core-libraries)
    - [Freezed](#freezed)
    - [gen-l10n](#gen-l10n)
    - [Riverpod](#bloc)
    - [Injectable & Get_it](#injectable--get_it)
  - [Architecture](#architecture)
    - [Presentation](#presentation)
    - [Application](#application)
    - [Domain](#domain)
    - [Infrastructure](#infrastructure)
  - [Folder Structure](#folder-structure)
  - [Running Tests 🧪](#running-tests-)
  - [Working with Translations 🌐](#working-with-translations-)
    - [Adding Strings](#adding-strings)
    - [Adding Supported Locales](#adding-supported-locales)
    - [Adding Translations](#adding-translations)
  - [Scripts](#scripts)

## Getting Started 🚀
This project is a Flutter application named BardBeats, designed to provide personalized music recommendations for users. The main features include song selection, liking or disliking songs, and receiving custom song recommendations based on user preferences.

The application integrates various services to enhance user experience:

- **Firestore:** Utilized for storing user preferences and song data.
- **Firebase Authentication:** This service is used for securely managing user logins and sign-ups.
- **Firebase Cloud Functions:** Leveraged for backend logic, including recommendation algorithms and data processing.

BardBeats is developed with a focus on clean architecture principles, employing the Model-View-Presenter (MVP) pattern and Riverpod for state management to ensure the codebase is maintainable and scalable.

### Installation

To set up the development environment, follow these steps:

1. Clone the BardBeats repository: `git clone [[BardBeats Repository URL]](https://github.com/ElMehdijebbour/bard_beats_web/)`
2. Navigate into the project directory: `cd bardbeatsdash`
3. Install dependencies: `flutter pub get`
4. (Optional) Run the build script: `./scripts/build_and_gen.sh`
5. Set up your `.env` file and `local.properties` file. See [Handling Environment Variables](#handling-environment-variables) for more details.

Please ensure you have Flutter installed and set up on your machine before proceeding. For more detailed instructions, see the [Flutter Setup Guide](https://flutter.dev/docs/get-started/install).

This project contains 1 flavor:

- development

To run the desired flavor (we are using only the dev flavor for now) either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run 
```

_\*Bard Beats works on iOS, Android, Web, and Windows, This version is only supported for web!

---
## Handling Environment Variables

In this project, we use environment variables to securely store sensitive data such as the Google Cloud API key. Here's how to configure it:

### In .env file

1. **Create a `.env` File**: In the root directory of the project, create a file named `.env`.
2. **Copy Example File**: An `.env.example` file has been provided with the required structure. Copy the content from `.env.example` into `.env`.
3. **Add Your API Key**: In the `.env` file, replace `YOUR_GOOGLE_CLOUD_API_KEY_HERE` with your actual Google Cloud API key.
4. **Never Commit `.env`**: This file contains sensitive information and should never be committed. Ensure that your `.gitignore` file includes `.env`.

### In local.properties file (For Android)

1. **Open `local.properties`**: Go to the `android` directory and open the `local.properties` file.
2. **Add Your API Key**: Append the following line at the end of the file, replacing `your_actual_api_key_here` with your actual Google Cloud API key.
 `GOOGLE_CLOUD_API_KEY=your_actual_api_key_here`
3. **Sync Project**: If you're using Android Studio, you might need to sync the project with Gradle files.

By following these steps, your sensitive API keys are kept secure and not exposed in your code repository, maintaining the security and integrity of your application.


---
## Technical Overview

This project follows a specific architecture known as 'MVP'. The architecture emphasizes Model View Presenter Principles. 

Before diving into the code, it is highly recommended to familiarize yourself with these concepts. The following resources should provide a solid foundation:

- [Flutter Firebase & DDD Course – Domain-Driven Design Principles](https://www.youtube.com/watch?v=RMiN59x3uH0&t=2s)
- [Freezed ❄ – Data Class & Union in One Dart Package](https://www.youtube.com/watch?v=ApvMmTrBaFI)
- [Flutter BLoC Pattern Official documentation MUST READ](https://bloclibrary.dev/#/gettingstarted)
- [Flutter BLoC Pattern Tutorial](https://www.youtube.com/watch?v=ApvMmTrBaFI)
- [Flutter Injectable package Tutorial](https://www.youtube.com/watch?v=KNcP8z0hWqs)
---


## Core Libraries

This project relies on a few core libraries that are integral to its architecture and functionality. 

### Freezed

[Freezed](https://pub.dev/packages/freezed) is a code generator for unions/pattern-matching/copy in Dart. It enables efficient handling of immutable classes and provides a neat and simple way to define immutable data classes and unions in Dart. It helps reduce boilerplate and enforce immutability in your Dart code. It's advisable to familiarize yourself with this library as it is extensively used throughout this project.

### gen-l10n

[gen-l10n](https://flutter.dev/docs/development/accessibility-and-localization/internationalization) is a Flutter tool used for internationalizing apps. It generates localizations automatically during the build process based on the `.arb` files provided. In this project, it's used to support multiple languages and to provide a robust and scalable solution for localization.

### Riverpod

[Riverpod](https://riverpod.dev/) is a state management library for Flutter, designed to enhance the robustness and scalability of applications. It offers a refined approach to managing state and dependencies in Dart and Flutter applications. In BardBeats, Riverpod is utilized for its predictability, flexibility, and testability.

Riverpod stands out for its ability to:

- **Decouple State Management from UI:** It allows developers to manage the state independently of the UI, making the codebase more maintainable and scalable.
- **Provide Immutable State:** Riverpod encourages the use of immutable states, which leads to more predictable and error-free code.
- **Ensure Compile-Time Safety:** The library is designed to catch errors early, during development, rather than at runtime.
- **Facilitate Testing:** With Riverpod, testing becomes more straightforward due to its decoupled nature and the ease of mocking dependencies.

Riverpod is used in BardBeats to:

- **Manage Application State:** Handling the state of various components within the app, from user preferences to the dynamic UI states.
- **Separate Logic from UI:** Following Clean Architecture principles, Riverpod helps in separating business logic from the presentation layer, making the code more modular and easier to understand.
- **Enhance Code Reusability:** By structuring state management, it allows for greater reusability of code across different parts of the application.

For a deeper understanding and practical examples of using Riverpod in BardBeats, refer to the [official Riverpod documentation](https://riverpod.dev/). The documentation provides comprehensive guidelines and best practices for implementing Riverpod effectively in Flutter projects.


### Injectable & Get_it

Injectable and Get_it are key libraries in our project that help us implement dependency injection effectively.

[Injectable](https://pub.dev/packages/injectable) is a simple and easy-to-use code generator for dependency injection in Dart and Flutter. It's based on annotations, and it uses `get_it` under the hood for the actual registration of services. It supports various injection methods, including factory and singleton injections, and provides a way to automatically register your dependencies.

[Get_it](https://pub.dev/packages/get_it) is a service locator for Dart and Flutter projects, and is used along with Injectable for dependency injection. Get_it allows us to decouple the instantiation of our objects from the place they are used. This greatly facilitates testing and allows us to easily swap out implementations.

These libraries are used throughout the project to manage dependencies, providing a clear and concise way to manage object lifetimes and making the code more modular and easier to test. Please refer to the [Injectable Documentation](https://pub.dev/packages/injectable) and the [Get_it Documentation](https://pub.dev/packages/get_it) for more details and usage examples.

