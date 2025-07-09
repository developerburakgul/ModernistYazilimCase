//
//  UsersInteractorProtocol.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation

@MainActor
protocol UsersInteractorProtocol {
    func fetchUsers() async throws -> [User]
    func addFavoriteUser(_ user: User) throws
    func removeFavoriteUser(_ user: User) throws
    func isFavoriteUser(_ user: User)  throws -> Bool
}

extension CoreInteractor: UsersInteractorProtocol {}


