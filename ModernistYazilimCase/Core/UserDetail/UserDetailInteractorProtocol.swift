//
//  UserDetailInteractorProtocol.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//


@MainActor
protocol UserDetailInteractorProtocol {
    func addFavoriteUser(_ user: User) throws
    func removeFavoriteUser(_ user: User) throws
    func isFavoriteUser(_ user: User) throws -> Bool
}

extension CoreInteractor: UserDetailInteractorProtocol {

}
