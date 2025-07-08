//
//  FavoritesManager.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//

import Foundation

@MainActor
protocol FavoritesManagerProtocol {
    func fetchFavoriteUsers() throws -> [User]
    func removeFavoriteUser(_ user: User)  throws
    func addFavoriteUser(_ user: User)  throws
    func isFavoriteUser(_ user: User)  throws -> Bool
}

@MainActor
final class FavoritesManager: ObservableObject, FavoritesManagerProtocol {
    let persistence: FavoritesPersistenceProtocol
    
    init(favoritesPersistenceService: FavoritesPersistenceProtocol) {
        self.persistence = favoritesPersistenceService
    }
    
    func fetchFavoriteUsers() throws -> [User] {
        try persistence.fetchFavoriteUserEntities().map { $0.convertToUser() }
    }
    
    func removeFavoriteUser(_ user: User)  throws {
        try persistence.removeFavorites(userEntity: user.convertToUserEntity())
    }
    
    func addFavoriteUser(_ user: User)  throws {
        try persistence.addFavorites(userEntity: user.convertToUserEntity())
    }
    
    func isFavoriteUser(_ user: User)  throws -> Bool {
        let user = try fetchFavoriteUsers().first { $0.id == user.id }
        if user == nil {
            return false
        }
        return true
    }
    

}
