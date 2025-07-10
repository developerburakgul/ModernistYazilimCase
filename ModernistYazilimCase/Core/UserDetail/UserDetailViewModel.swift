//
//  UserDetailViewModel.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//

import Foundation



@MainActor
final class UserDetailViewModel: ObservableObject {
    private let interactor: UserDetailInteractorProtocol
    private var user: User
    @Published private(set) var state: LoadingState<User> = .idle
    @Published var isFavorite: Bool = false
    
    init(interactor: UserDetailInteractorProtocol, user: User) {
        self.interactor = interactor
        self.user = user
        self.state = .loaded(user)
        self.isFavorite = user.isFavorite
    }
    
    func loadData() async {
        state = .loading
        do {
            isFavorite = try interactor.isFavoriteUser(user)
            state = .loaded(user)
        } catch  {
            
        }
    }
    
    func toggleFavorite() {
        isFavorite.toggle()
        do {
            if isFavorite {
                try interactor.addFavoriteUser(user)
            } else {
                try interactor.removeFavoriteUser(user)
            }
        } catch  {
            
        }
        
    }

}
