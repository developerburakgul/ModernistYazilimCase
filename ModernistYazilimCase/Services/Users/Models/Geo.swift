//
//  Geo.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation
import MapKit
struct Geo: Hashable, Codable {
    let lat: String
    let lng: String
    
    func getCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        let defaultLatitude: CLLocationDegrees = 34.011_286
        let defaultLongitude: CLLocationDegrees = 116.166_868
        
        let latitude = lat.convertToCLLocationDegrees() ?? defaultLatitude
        let longitude = lng.convertToCLLocationDegrees() ?? defaultLongitude
        
        // Dönüşüm başarısızsa konsola hata yazdır
        if lat.convertToCLLocationDegrees() == nil {
            print("Latitude conversion failed for: \(lat)")
        }
        if lng.convertToCLLocationDegrees() == nil {
            print("Longitude conversion failed for: \(lng)")
        }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Geo {
    func convertToGeoModel() -> GeoModel {
        return GeoModel(lat: lat, lng: lng)
    }
}
