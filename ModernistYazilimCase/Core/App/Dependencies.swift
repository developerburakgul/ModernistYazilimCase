//
//  Dependencies.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation
import MBWebService

@MainActor
struct Dependencies {
    let container: DependencyContainer
    //MARK: - MANAGERS
    let userManager: UserManagerProtocol
    let webService: MBWebServiceProtocol
    
    init() {
        let container = DependencyContainer()
        
        self.webService = MBWebService.shared
        self.userManager = UserManager(webService: webService)
        container.register(MBWebServiceProtocol.self, service: webService)
        container.register(UserManagerProtocol.self, service: userManager)
        
        self.container = container
    }
}
