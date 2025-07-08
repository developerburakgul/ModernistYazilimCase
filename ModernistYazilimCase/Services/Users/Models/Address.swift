//
//  Address.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation
struct Address: Hashable, Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

extension Address {
    func convertToAddressModel() -> AddressModel {
        return AddressModel(street: street, suite: suite, city: city, zipcode: zipcode, geo: geo.convertToGeoModel())
    }
}
