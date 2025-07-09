//
//  DevPreview.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation
import SwiftUI
import MBWebService


@MainActor
class DevPreview {
    static let shared = DevPreview()
    
    var container: DependencyContainer {
        let container = DependencyContainer()
        container.register(MBWebServiceProtocol.self, service: webService)
        container.register(UserManagerProtocol.self, service: userManager)
        container.register(FavoritesPersistenceProtocol.self, service: favoritesPersistenceService)
        container.register(FavoritesManagerProtocol.self, service: favoritesManager)
        container.register(LanguageManagerProtocol.self, service: languageManager)
        return container
    }
    let webService: MBWebServiceProtocol
    let userManager: UserManagerProtocol
    let favoritesPersistenceService: FavoritesPersistenceProtocol
    let favoritesManager: FavoritesManagerProtocol
    let languageManager: LanguageManagerProtocol
    
    init(){
        self.webService = MBWebService.shared
        self.userManager = MockUserManager(webService: webService)
        self.favoritesPersistenceService = SwiftDataFavoritesPersistence()
        self.favoritesManager = FavoritesManager(favoritesPersistenceService: favoritesPersistenceService)
        self.languageManager = LanguageManager()
    }
}

extension View {
    func previewEnvironment() -> some View {
        self
            .environmentObject(DevPreview.shared.container)
//            .environmentObject(MockUserManager(webService: MBWebService.shared))
    }
}
