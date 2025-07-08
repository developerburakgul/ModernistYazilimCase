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
    func makeUserDetailViewModel(user: User) -> UserDetailViewModel
}

@MainActor
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
    
    func makeUserDetailViewModel(user: User) -> UserDetailViewModel {
        UserDetailViewModel(interactor: coreInteractor as UserDetailInteractorProtocol, user: user)
    }
}
