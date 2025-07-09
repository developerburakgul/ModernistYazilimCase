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
    private(set) var users: [User] = []
    @Published private(set) var state: LoadingState<[User]> = .idle
    @Published var selectedUser: User?
    
    init(interactor: FavoritesInteractorProtocol) {
        self.interactor = interactor
    }

    func loadData() async {
        state = .loading
        do {
            let users = try interactor.fetchFavoriteUsers()
            self.users = users
            await MainActor.run {
                state = .loaded(users)
            }
        } catch  {
            //MARK: - TODO FOR ERROR
            let userError = UserError(title: "Error", description: error.localizedDescription)
            dump(error)
            state = .failed(userError)
        }
    }
    
    func deleteFavorites(user: User) {
        do {
            try interactor.removeFavoriteUser(user)
        } catch  {
            //MARK: - TODO
        }
    }
    
}
