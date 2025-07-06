//
//  ViewModelFactory.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation


@MainActor
protocol ViewModelFactoryProtocol {
    func makeUsersViewModel() -> UsersViewModel
    func makeFavoritesViewModel() -> FavoritesViewModel
}

struct ViewModelFactory: ViewModelFactoryProtocol {
    private let coreInteractor: CoreInteractor
    
    init(container: DependencyContainer) {
        self.coreInteractor = CoreInteractor(container: container)
    }
    func makeUsersViewModel() -> UsersViewModel {
        UsersViewModel(interactor: coreInteractor as UsersInteractorProtocol)
    }
    func makeFavoritesViewModel() -> FavoritesViewModel {
        FavoritesViewModel(interactor: coreInteractor as FavoritesInteractorProtocol)
    }
}
