//
//  String+Extension.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation
import MapKit
extension String {
    func convertToCLLocationDegrees() -> CLLocationDegrees? {
        CLLocationDegrees(self)
    }
}
