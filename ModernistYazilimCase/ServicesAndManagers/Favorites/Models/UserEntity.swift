//
//  UserEntity.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//

import Foundation
import SwiftData

//struct User: Hashable {
//    let id: Int
//    let name: String
//    let userName: String
//    let email: String
//    let address: Address
//    let phone: String
//    let website: String
//    let company: Company
//}

@Model
class UserEntity {
    @Attribute(.unique) var userID: Int
    var name: String
    var userName: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    var isFavorite: Bool
    
    init(from user: User) {
        self.userID = user.id
        self.name = user.name
        self.userName = user.userName
        self.email = user.email
        self.address = user.address
        self.phone = user.phone
        self.website = user.website
        self.company = user.company
        self.isFavorite = user.isFavorite
    }
    
    init(
        userID: Int,
        name: String,
        userName: String,
        email: String,
        address: Address,
        phone: String,
        website: String,
        company: Company,
        isFavorite: Bool
    ) {
        self.userID = userID
        self.name = name
        self.userName = userName
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
        self.isFavorite = isFavorite
    }
    
    func convertToUser() -> User {
        return User(
            id: userID,
            name: name,
            userName: userName,
            email: email,
            address: address,
            phone: phone,
            website: website,
            company: company,
            isFavorite: isFavorite
        )
    }
}


