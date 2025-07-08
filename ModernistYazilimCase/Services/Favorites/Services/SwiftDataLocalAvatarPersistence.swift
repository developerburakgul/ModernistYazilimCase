//
//  SwiftDataLocalAvatarPersistence.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//
import Foundation
import SwiftData

@MainActor
protocol FavoritesPersistenceProtocol {
    func addFavorites(userEntity: UserEntity) throws
    func removeFavorites(userEntity: UserEntity) throws
    func fetchFavoriteUserEntities() throws  -> [UserEntity]
}

@MainActor
struct SwiftDataFavoritesPersistence: FavoritesPersistenceProtocol {
    
    private let container: ModelContainer
    
    private var mainContext: ModelContext {
        container.mainContext
    }
    
    init() {
        // swiftlint:disable:next force_try
        self.container = try! ModelContainer(for: UserEntity.self)
    }
    
    func addFavorites(userEntity: UserEntity) throws {
        mainContext.insert(userEntity)
        try mainContext.save()
    }
    
    func removeFavorites(userEntity: UserEntity) throws {
        mainContext.delete(userEntity)
        try mainContext.save()
    }
    
    func fetchFavoriteUserEntities() throws  -> [UserEntity] {
        let descriptor = FetchDescriptor<UserEntity>()
        return try mainContext.fetch(descriptor)
    }
    
//    func addRecentAvatar(avatar: AvatarModel) throws {
//        let entity = AvatarEntity(from: avatar)
//        mainContext.insert(entity)
//        try mainContext.save()
//    }
//    
//    func getRecentAvatars() throws -> [AvatarModel] {
//        let descriptor = FetchDescriptor<AvatarEntity>(sortBy: [SortDescriptor(\.dateAdded, order: .reverse)])
//        let entities = try mainContext.fetch(descriptor)
//        return entities.map({ $0.toModel() })
//    }
}
