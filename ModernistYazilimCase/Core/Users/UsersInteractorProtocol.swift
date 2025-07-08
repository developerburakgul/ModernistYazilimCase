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
    func addFavoriteUser(_ user: User)
    func deleteFavoriteUser(_ user: User)
}

extension CoreInteractor: UsersInteractorProtocol {}

