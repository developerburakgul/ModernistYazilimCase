//
//  User.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation

struct User {
    let id: Int
    let name: String
    let userName: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}

extension User {
    func convertToUserModel() -> UserModel {
        return UserModel(
            id: self.id,
            name: self.name,
            username: self.userName,
            email: self.email,
            address: self.address.convertToAddressModel(),
            phone: self.phone,
            website: self.website,
            company: self.company.convertToCompanyModel()
        )
    }
}
