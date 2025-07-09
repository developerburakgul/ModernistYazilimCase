//
//  FavoritesInteractorProtocol.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//
import Foundation

@MainActor
protocol FavoritesInteractorProtocol {
    func fetchFavoriteUsers() throws -> [User]
    func removeFavoriteUser(_ user: User)  throws
}

extension CoreInteractor: FavoritesInteractorProtocol {}
