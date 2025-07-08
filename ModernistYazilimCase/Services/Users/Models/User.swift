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
    
   static func mock() -> User {
        .init(
            id: 1,
            name: "Leanne Graham",
            userName: "Bret",
            email: "Sincere@april.biz",
            address: .init(
                street: "Kulas Light",
                suite: "Apt. 556",
                city: "Gwenborough",
                zipcode: "92998-3874",
                geo: .init(lat: "-37.3159", lng: "81.1496")
            ),
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: .init(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
        )
    }
}
