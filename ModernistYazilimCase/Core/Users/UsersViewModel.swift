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
    
    @Published private(set) var state: LoadingState<[User]> = .idle
    @Published var selectedUser: User?
    @Published var shouldGoToSettings: Bool = false
    private var originalUsers: [User] = []
    
    init(interactor: UsersInteractorProtocol) {
        self.interactor = interactor
    }
    
    func loadData() async {
        state = .loading
        do {
            let users = try await interactor.fetchUsers()
            originalUsers = users
            state = .loaded(users)
        } catch  {
            state = .failed(UserError(title: TextKey.error.stringValue.capitalized, description: TextKey.errorDescription.stringValue.capitalized))
        }
    }
        
    func userDidSearch(_ text: String) {
        guard !text.isEmpty else {
            state = .loaded(originalUsers)
            return
        }
        let filtered = originalUsers.filter { $0.name.lowercased().contains(text.lowercased()) }
        state = .loaded(filtered)
    }
    
    func addFavorites(user: User) {
        do {
            try interactor.addFavoriteUser(user)
        } catch  {
            state = .failed(UserError(title: TextKey.error.stringValue.capitalized, description: TextKey.errorDescription.stringValue.capitalized))
        }
        
    }
    
    func deleteFavorites(user: User) {
        state = .loading
        Task {
            do {
                try interactor.removeFavoriteUser(user)
                originalUsers = try  await interactor.fetchUsers()
                state = .loaded(originalUsers)
            } catch  {
                state = .failed(UserError(title: TextKey.error.stringValue.capitalized, description: TextKey.errorDescription.stringValue.capitalized))
            }
        }
       
    }
    
    func isFavoriteUser(_ user: User) -> Bool {
        do {
            return try interactor.isFavoriteUser(user)
        } catch{
            return false
        }
    }
    
    func clickSettingsButton() {
        shouldGoToSettings = true
    }
}
