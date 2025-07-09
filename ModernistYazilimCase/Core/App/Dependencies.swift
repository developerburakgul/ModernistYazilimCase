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
    let favoritesManager: FavoritesManagerProtocol
    let favoritesPersistenceService: FavoritesPersistenceProtocol
    let languageManager: LanguageManagerProtocol
    
    init() {
        let container = DependencyContainer()
        
        self.webService = MBWebService.shared
        self.userManager = UserManager(webService: webService)
        container.register(MBWebServiceProtocol.self, service: webService)
        container.register(UserManagerProtocol.self, service: userManager)
        
        self.favoritesPersistenceService = SwiftDataFavoritesPersistence()
        container.register(FavoritesPersistenceProtocol.self, service: favoritesPersistenceService)
        
        self.favoritesManager = FavoritesManager(favoritesPersistenceService: favoritesPersistenceService)
        container.register(FavoritesManagerProtocol.self, service: favoritesManager)
        
        self.languageManager = LanguageManager()
        container.register(LanguageManagerProtocol.self, service: languageManager)
        
        self.container = container
    }
}
