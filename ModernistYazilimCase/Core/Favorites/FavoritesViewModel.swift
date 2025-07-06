//
//  FavoritesViewModel.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation


@MainActor
final class FavoritesViewModel: ObservableObject {
    private let interactor: FavoritesInteractorProtocol
    
    init(interactor: FavoritesInteractorProtocol) {
        self.interactor = interactor
    }
}
