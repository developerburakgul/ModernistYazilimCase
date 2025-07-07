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
}

extension CoreInteractor: UsersInteractorProtocol {}

