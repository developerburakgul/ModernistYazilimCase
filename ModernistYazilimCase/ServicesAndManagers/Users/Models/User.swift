//
//  User.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation

struct User: Hashable {
    let id: Int
    let name: String
    let userName: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    let isFavorite: Bool
    
    var imageURLString: String {
        "\(Constants.imageBaseURL)\(id)"
    }
}

extension User {

    
    func convertToUserEntity() -> UserEntity {
        return UserEntity(from: self)
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
                geo: .init(lat: "-24.8918", lng: "21.8984")
            ),
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: .init(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets"), isFavorite: true
        )
    }
}
