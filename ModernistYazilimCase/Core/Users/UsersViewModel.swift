//
//  UsersViewModel.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation


@MainActor
final class UsersViewModel: ObservableObject {
    private let interactor: UsersInteractorProtocol
    
    init(interactor: UsersInteractorProtocol) {
        self.interactor = interactor
    }
}
