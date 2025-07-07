//
//  UserModel.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation
// MARK: - User
struct UserModel: Codable {
    let id: Int
    let name, username, email: String
    let address: AddressModel
    let phone, website: String
    let company: CompanyModel
}

extension UserModel {
    func convertToUser() -> User {
        return User(
            id: self.id,
            name: self.name,
            userName: self.username,
            email: self.email,
            address: self.address.convertToAddress(),
            phone: self.phone,
            website: self.website,
            company: self.company.convertToCompany()
        )
    }
}

// MARK: - Address
struct AddressModel: Codable {
    let street, suite, city, zipcode: String
    let geo: GeoModel
}

extension AddressModel {
    func convertToAddress() -> Address {
        return Address(
            street: self.street,
            suite: self.suite,
            city: self.city,
            zipcode: self.zipcode,
            geo: self.geo.convertToGeo()
        )
    }
}

// MARK: - Geo
struct GeoModel: Codable {
    let lat, lng: String
}

extension GeoModel {
    func convertToGeo() -> Geo {
        return Geo(
            lat: self.lat,
            lng: self.lng
        )
    }
}

// MARK: - Company
struct CompanyModel: Codable {
    let name, catchPhrase, bs: String
}

extension CompanyModel {
    func convertToCompany() -> Company {
        return Company(
            name: self.name,
            catchPhrase: self.catchPhrase,
            bs: self.bs
        )
    }
}
