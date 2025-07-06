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
    
    @Published private(set) var state: LoadingState<String> = .idle
    
    init(interactor: UsersInteractorProtocol) {
        self.interactor = interactor
    }
    
    func loadData() {
        state = .loading
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000)
            state = .loaded("Veri Geldi")
        }
    }
}
