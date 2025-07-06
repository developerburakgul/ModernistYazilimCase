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
}

struct ViewModelFactory: ViewModelFactoryProtocol {
    let coreInteractor: CoreInteractor
    func makeUsersViewModel() -> UsersViewModel {
        UsersViewModel(interactor: coreInteractor as UsersInteractorProtocol)
    }
}
