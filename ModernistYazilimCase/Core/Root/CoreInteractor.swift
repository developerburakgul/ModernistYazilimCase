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
    init(container: DependencyContainer) {
        self.userManager = container.resolve(UserManagerProtocol.self)!
    }
    
    //MARK: - USER MANAGER
    func fetchUsers() async throws -> [User] {
        try await userManager.fetchUsers()
    }
}


