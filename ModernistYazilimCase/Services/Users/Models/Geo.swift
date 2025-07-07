//
//  Geo.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation
struct Geo {
    let lat: String
    let lng: String
}

extension Geo {
    func convertToGeoModel() -> GeoModel {
        return GeoModel(lat: lat, lng: lng)
    }
}
