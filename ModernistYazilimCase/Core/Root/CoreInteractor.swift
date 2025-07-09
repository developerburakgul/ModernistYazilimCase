//
//  CoreInteractor.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation


@MainActor
struct CoreInteractor {
    //MARK: - TODO: Define Managers on Here
    private let userManager: UserManagerProtocol
    private let favoritesManager: FavoritesManagerProtocol
    private let languageManager: LanguageManagerProtocol
    init(container: DependencyContainer) {
        self.userManager = container.resolve(UserManagerProtocol.self)!
        self.favoritesManager = container.resolve(FavoritesManagerProtocol.self)!
        self.languageManager = container.resolve(LanguageManagerProtocol.self)!
    }
    
    //MARK: - USER MANAGER
    func fetchUsers() async throws -> [User] {
        try await userManager.fetchUsers()
    }
    
    //MARK: - FAVORITES MANAGER
    func addFavoriteUser(_ user: User) throws {
        try favoritesManager.addFavoriteUser(user)
    }
    
    func removeFavoriteUser(_ user: User) throws {
        try favoritesManager.removeFavoriteUser(user)
    }
    
    func fetchFavoriteUsers() throws -> [User] {
        try favoritesManager.fetchFavoriteUsers()
    }
    
    func isFavoriteUser(_ user: User) throws -> Bool {
        try favoritesManager.isFavoriteUser(user)
    }
    
    //MARK: - LOCALIZATION MANAGER
    func setLanguage(_ language: Language) {
        languageManager.setLanguage(language)
    }
    func getLanguage() -> Language {
        languageManager.getLanguage()
    }
}


