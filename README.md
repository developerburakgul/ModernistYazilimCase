# Modernist Case

A simple iOS application built with modern ## Features

- Built with **SwiftUI** for the user interface.
- Uses **MVVM + Interactor** architecture for clear separation of concerns.
- Custom **Dependency Injection** container inspired by Swinject.
- **Unit tests** written with SwiftTesting.
- **SwiftData** used for local data persistence.
- Networking powered by a custom SPM package: **MBWebService** (`development` branch).
- **Localization support** via a centralized `languageManager`, allowing easy language changes from any ViewModel and keeping localization logic scalable and testable.

---Swift technologies and best practices.

## Getting Started

1. Clone the repository.
2. Open the project in Xcode.
3. Run `swift package resolve` if needed.
4. Build and run on your preferred simulator or device.

---

## Features

- Built with **SwiftUI** for the user interface.
- Uses **MVVM + Interactor** architecture for clear separation of concerns.
- Custom **Dependency Injection** container inspired by Swinject.
- **Unit tests** written with SwiftTesting.
- **SwiftData** used for local data persistence.
- Networking powered by a custom SPM package: **MBWebService** (`development` branch).

---


## Architecture

![Architecture Diagram](architecture/diagram.png)

The project follows the **MVVM + Interactor** pattern for scalability and testability.

- **Each ViewModel depends on its own Interactor Protocol** (e.g., `UsersInteractorProtocol`, `FavoritesInteractorProtocol`, `SettingsInteractorProtocol`), which exposes only the necessary business logic for that feature.
- All these protocols are implemented by a single `CoreInteractor` class. This means:
  - **ViewModels only access the functions they need**, not the entire business logic, reducing coupling and preventing accidental misuse.
  - **No code duplication**: shared logic is implemented once in `CoreInteractor` and reused across features.
  - **Easy to test and extend**: you can mock protocols for unit tests or add new features by extending protocols and `CoreInteractor`.

**Protocols for each feature:**

```swift
// UsersInteractorProtocol
@MainActor
protocol UsersInteractorProtocol {
    func fetchUsers() async throws -> [User]
    func addFavoriteUser(_ user: User) throws
    func removeFavoriteUser(_ user: User) throws
    func isFavoriteUser(_ user: User) throws -> Bool
}

// FavoritesInteractorProtocol
@MainActor
protocol FavoritesInteractorProtocol {
    func fetchFavoriteUsers() throws -> [User]
    func removeFavoriteUser(_ user: User) throws
}

// SettingsInteractorProtocol
@MainActor
protocol SettingsInteractorProtocol {
    func setLanguage(_ language: Language)
    func getLanguage() -> Language
}
```

**CoreInteractor implements all protocols:**

```swift
@MainActor
struct CoreInteractor {
    private let userManager: UserManagerProtocol
    private let favoritesManager: FavoritesManagerProtocol
    private let languageManager: LanguageManagerProtocol

    init(container: DependencyContainer) {
        self.userManager = container.resolve(UserManagerProtocol.self)!
        self.favoritesManager = container.resolve(FavoritesManagerProtocol.self)!
        self.languageManager = container.resolve(LanguageManagerProtocol.self)!
    }

    // User-related
    func fetchUsers() async throws -> [User] {
        try await userManager.fetchUsers()
    }
    func addFavoriteUser(_ user: User) throws {
        try favoritesManager.addFavoriteUser(user)
    }
    func removeFavoriteUser(_ user: User) throws {
        try favoritesManager.removeFavoriteUser(user)
    }
    func isFavoriteUser(_ user: User) throws -> Bool {
        try favoritesManager.isFavoriteUser(user)
    }

    // Favorites-related
    func fetchFavoriteUsers() throws -> [User] {
        try favoritesManager.fetchFavoriteUsers()
    }

    // Settings-related
    func setLanguage(_ language: Language) {
        languageManager.setLanguage(language)
    }
    func getLanguage() -> Language {
        languageManager.getLanguage()
    }
}

// CoreInteractor implements all feature protocols
extension CoreInteractor: UsersInteractorProtocol, FavoritesInteractorProtocol, SettingsInteractorProtocol {}
```

**ViewModel examples:**

```swift
// UsersViewModel depends only on UsersInteractorProtocol
@MainActor
final class UsersViewModel: ObservableObject {
    private let interactor: UsersInteractorProtocol
    // ...
}

// FavoritesViewModel depends only on FavoritesInteractorProtocol
@MainActor
final class FavoritesViewModel: ObservableObject {
    private let interactor: FavoritesInteractorProtocol
    // ...
}

// SettingsViewModel depends only on SettingsInteractorProtocol
@MainActor
final class SettingsViewModel: ObservableObject {
    private let interactor: SettingsInteractorProtocol
    // ...
}
```

This modular approach keeps your codebase clean, maintainable, and scalable.

---

## MBWebService Example

Here’s a real-world usage of the **MBWebService** SPM package via protocol-based dependency injection, as used in `UserManager`:

```swift
import MBWebService

@MainActor
protocol UserManagerProtocol {
    func fetchUsers() async throws -> [User]
}

@MainActor
final class UserManager: ObservableObject, UserManagerProtocol {
    private let webService: MBWebServiceProtocol

    init(webService: MBWebServiceProtocol) {
        self.webService = webService
    }

    func fetchUsers() async throws -> [User] {
        let userModels: [UserModel] = try await webService.fethcData<[UserModel]>(
            urlString: Paths.users.getFullPath(),
            queryItems: nil,
            header: .defaultHttpHeader,
            method: .GET,
            body: nil,
            checkStatusCode: false,
            timeoutInterval: 60
        )
        return userModels.map { $0.convertToUser() }
    }
}
```

This approach allows you to inject any implementation of `MBWebServiceProtocol` (such as a mock for testing), making your networking layer flexible and testable.

---

## Demo Video

[![Watch on YouTube](https://img.youtube.com/vi/YOUR_VIDEO_ID/0.jpg)](https://youtube.com/watch?v=YOUR_VIDEO_ID)

---

## Screenshots

| Users Screen | Empty Favorites Screen | Users Screen | Users Search | Users Screen - Can Add Favorites |
|-------------|---------------|-------------|---------------| ---------------|
| ![Home](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/users.png) | ![Home](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/favorites-empty.png) | ![Home](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/users.png) | ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/users-search.png) | ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/users-can-add-favorite.png) |


 | User Detail Screen | User Detail Screen - Add Favorites | Users Screen - Can Delete Favorites | Favorites Screen  | Favorites Screen - Can Delete |
|-------------|---------------|-------------|---------------| ---------------|
| ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/userDetail-noFavorite.png) | ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/userDetail-addFavorite.png) |  ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/users-can-delete-favorite.png) |  ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/favorites-non-empty.png) |   ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/favorites-can-delete.png) | 

 | Settings Screen | Settings Screen - Select Language | |  |  |
|-------------|---------------| ---------------| ---------------| ---------------|
| ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/settings-english.png) | ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/settings-select-langugae.png) |  ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/settings-select-langugae.png) |  ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/settings-select-langugae.png) |  ![Detail](https://github.com/developerburakgul/ModernistYazilimCase/blob/main/screenshots/settings-select-langugae.png) | 

---
