//
//  Geo.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation
import MapKit
struct Geo {
    let lat: String
    let lng: String
    
    func getCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: lat.convertToCLLocationDegrees() ?? 34.011_286,
            longitude: lng.convertToCLLocationDegrees() ?? 116.166_868
        )
    }
}

extension Geo {
    func convertToGeoModel() -> GeoModel {
        return GeoModel(lat: lat, lng: lng)
    }
}
