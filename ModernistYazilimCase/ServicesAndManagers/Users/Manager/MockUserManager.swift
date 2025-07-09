//
//  MockUserManager.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation
import MBWebService

@MainActor
final class MockUserManager: ObservableObject, UserManagerProtocol {
    private let webService: MBWebServiceProtocol
    
    init(webService: MBWebServiceProtocol) {
        self.webService = webService
    }
    
    func fetchUsers() async throws -> [User] {
        do {
            let userModels: [UserModel] = try await webService.fethcData<[UserModel]>(
                urlString: Paths.users.getFullPath(),
                queryItems: nil,
                header: .defaultHttpHeader,
                method: .GET,
                body: nil,
                checkStatusCode: false,
                timeoutInterval: 60
            )
            return userModels.map { $0.convertToUser()}
        } catch  {
            throw error
        }
    }
}
