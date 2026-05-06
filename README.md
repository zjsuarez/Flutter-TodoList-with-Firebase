# 📝 TodoList App - Hive-FireBase

TodoList application built with Flutter, focusing on a seamless **Offline-First** experience. The app ensures users can manage their tasks without an internet connection,  syncing data to the cloud in the background once connectivity is restored.

## ✨ Key Features

*   **Offline-First Architecture:** The app works flawlessly whether you are offline or online.
*   **Local Storage:** Uses [Hive](https://pub.dev/packages/hive) to save and retrieve information locally without lag.
*   **Cloud Backup:** Automatically syncs and backs up local data securely to **Firebase**.
*   **State Management:** Uses **BLoC** to maintain a clean, reactive, and testable UI state.
*   **Dependency Injection:** Managed smoothly through **get_it** for decoupled and maintainable code.

## 🏗 Architecture

This project strictly follows a **Feature-First Clean Architecture** approach. 
Each feature is completely encapsulated, containing its own isolated layers:
*   **Presentation:** UI and BLoC.
*   **Domain:** Entities and Use Cases.
*   **Data:** Repositories, Data Sources (Hive & Firebase), and Models.

## 🛠 Tech Stack

*   **Framework:** Flutter
*   **State Management:** flutter_bloc
*   **Local Database:** Hive
*   **Cloud Services:** Firebase
*   **Service Locator:** get_it

## 📚 Learning Resources & References

* Hive Tutorial: https://ms3byoussef.medium.com/hive-in-flutter-a-detailed-guide-with-injectable-freezed-and-cubit-in-clean-architecture-c5c12ce8e00c
