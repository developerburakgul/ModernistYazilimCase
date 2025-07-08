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
    var users: [User] = []
    
    init(interactor: UsersInteractorProtocol) {
        self.interactor = interactor
    }
    
    func loadData() async {
        state = .loading
        do {
            let users = try await interactor.fetchUsers()
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
    
    func userDidSearch(_ text: String) {
        guard !text.isEmpty else {
            state = .loaded(users)
            return
        }
        state = .loading
        let filteredUsers = users.filter { $0.name.lowercased().contains(text.lowercased()) }
        state = .loaded(filteredUsers)
    }
}
