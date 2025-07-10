//
//  UsersViewTests.swift
//  ModernistYazilimCaseTests
//
//  Created by Burak Gül on 9.07.2025.
//

import Testing
import SwiftUI
@testable import ModernistYazilimCase

@MainActor
struct UserViewTests {
    @MainActor
    struct AnyUsersInteractor: UsersInteractorProtocol {
        let anyFetchUsers: () async throws -> [ModernistYazilimCase.User]
        let anyAddFavoriteUser: (ModernistYazilimCase.User) throws -> Void
        let anyRemoveFavoriteUser: (ModernistYazilimCase.User) throws -> Void
        let anyIsFavoriteUser: (ModernistYazilimCase.User) throws -> Bool
        
        init(
            anyFetchUsers: @escaping () -> [ModernistYazilimCase.User],
            anyAddFavoriteUser: @escaping (ModernistYazilimCase.User) -> Void,
            anyRemoveFavoriteUser: @escaping (ModernistYazilimCase.User) -> Void,
            anyIsFavoriteUser: @escaping (ModernistYazilimCase.User) -> Bool
        ) {
            self.anyFetchUsers = anyFetchUsers
            self.anyAddFavoriteUser = anyAddFavoriteUser
            self.anyRemoveFavoriteUser = anyRemoveFavoriteUser
            self.anyIsFavoriteUser = anyIsFavoriteUser
        }
        
        func fetchUsers() async throws -> [ModernistYazilimCase.User] {
            try await anyFetchUsers()
        }
        
        func addFavoriteUser(_ user: ModernistYazilimCase.User) throws {
            try anyAddFavoriteUser(user)
        }
        
        func removeFavoriteUser(_ user: ModernistYazilimCase.User) throws {
            try anyRemoveFavoriteUser(user)
        }
        
        func isFavoriteUser(_ user: ModernistYazilimCase.User) throws -> Bool {
            try anyIsFavoriteUser(user)
        }
        
    }
    
    
    
    @Test("loadData does succeed")
    func loadDataDoesSucceed() async throws {
        // Given
        let users: [User] = User.mockUsers()
        var favorites: [User] = []
        
        let interactor = AnyUsersInteractor {
            users
        } anyAddFavoriteUser: { user in
            favorites.append(user)
        } anyRemoveFavoriteUser: { _ in }
        anyIsFavoriteUser: { user in
            favorites.contains(user)
        }
        
        let viewModel = UsersViewModel(interactor: interactor)
        
        // When
        await viewModel.loadData()
        
        // Then
        switch viewModel.state {
        case .loaded(let userArray):
            #expect(userArray == users, "Loaded users do not match expected users.")
        default:
            #expect(Bool(false), "Expected .loaded state, got: \(viewModel.state)")
        }
    }
    
    @Test("userDidSearch does succeed")
    func userDidSearchDoesSucceed() async throws {
        // Given
        let users: [User] = User.mockUsers()
        var favorites: [User] = []
        let user: User = users[0]
        
        let interactor = AnyUsersInteractor {
            users
        } anyAddFavoriteUser: { user in
            favorites.append(user)
        } anyRemoveFavoriteUser: { _ in }
        anyIsFavoriteUser: { user in
            favorites.contains(user)
        }
        
        let viewModel = UsersViewModel(interactor: interactor)
        
        // when
        await viewModel.loadData()
        viewModel.userDidSearch(user.name)
        
        // Then
        switch viewModel.state {
        case .loaded(let userArray):
            #expect(userArray.count == 1, "Loaded users array has wrong count.")
            #expect(userArray == [user], "Loaded users array does not match expected.")
        default:
            #expect(Bool(false), "Unexpected state.")
        }
    }
    
    @Test("add Favorites does succeed")
    func addFavoritesDoesSucceed() async throws {
        // Given
        let users: [User] = User.mockUsers()
        var favorites: [User] = []
        let user: User = User(
            id: 1923,
            name: "Burak",
            userName: "Gül",
            email: "developerburakgul@gmail.com",
            address: .init(street: "Sivas Caddesi", suite: "", city: "Sivas", zipcode: "58600", geo: .init(lat: "12.32", lng: "15.67")),
            phone: "555-333-44-77",
            website: "iamburakgul.com",
            company: .init(name: "Modernist Yazilim", catchPhrase: "", bs: "1"),
            isFavorite: false
        )
        
        let interactor = AnyUsersInteractor {
            users
        } anyAddFavoriteUser: { user in
            favorites.append(user)
        } anyRemoveFavoriteUser: { _ in }
        anyIsFavoriteUser: { user in
            favorites.contains(user)
        }
        
        let viewModel = UsersViewModel(interactor: interactor)
        
        // when
        await viewModel.loadData()
        viewModel.addFavorites(user: user)
        
        // Then
        #expect(favorites.count == 1)
        #expect(favorites == [user])
    }
    
    @Test("delete Favorites does succeed")
    func deleteFavoritesDoesSucceed() async throws {
        // Given
        let users: [User] = User.mockUsers()
        var favorites: [User] = []
        let user: User = User(
            id: 1923,
            name: "Burak",
            userName: "Gül",
            email: "developerburakgul@gmail.com",
            address: .init(street: "Sivas Caddesi", suite: "", city: "Sivas", zipcode: "58600", geo: .init(lat: "12.32", lng: "15.67")),
            phone: "555-333-44-77",
            website: "iamburakgul.com",
            company: .init(name: "Modernist Yazilim", catchPhrase: "", bs: "1"),
            isFavorite: false
        )
        
        let interactor = AnyUsersInteractor {
            users
        } anyAddFavoriteUser: { user in
            favorites.append(user)
        } anyRemoveFavoriteUser: { user in
            favorites.removeAll { $0.id == user.id }
        } anyIsFavoriteUser: { user in
            favorites.contains(user)
        }
        
        let viewModel = UsersViewModel(interactor: interactor)
        
        await viewModel.loadData()
        viewModel.addFavorites(user: user)
        #expect(favorites.count == 1)
        
        // when
        viewModel.deleteFavorites(user: user)
        try await Task.sleep(for: .seconds(2))
        // Then
        #expect(favorites.count == 0)
        
    }
    @Test("Is Favorites does succeed")
    func isFavoritesDoesSucceed() async throws {
        // Given
        let users: [User] = User.mockUsers()
        var favorites: [User] = []
        let user: User = User(
            id: 1923,
            name: "Burak",
            userName: "Gül",
            email: "developerburakgul@gmail.com",
            address: .init(street: "Sivas Caddesi", suite: "", city: "Sivas", zipcode: "58600", geo: .init(lat: "12.32", lng: "15.67")),
            phone: "555-333-44-77",
            website: "iamburakgul.com",
            company: .init(name: "Modernist Yazilim", catchPhrase: "", bs: "1"),
            isFavorite: true
        )
        
        let interactor = AnyUsersInteractor {
            users
        } anyAddFavoriteUser: { user in
            favorites.append(user)
        } anyRemoveFavoriteUser: { user in
            favorites.removeAll { $0.id == user.id }
        } anyIsFavoriteUser: { user in
            favorites.contains(user)
        }
        
        let viewModel = UsersViewModel(interactor: interactor)
        
        await viewModel.loadData()
        
        // when
        viewModel.addFavorites(user: user)
        #expect(favorites.count == 1)
        
        // Then
        #expect(viewModel.isFavoriteUser(user))
        
    }
}

