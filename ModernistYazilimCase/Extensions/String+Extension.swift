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
        // String'i Double'a çevir, bölgesel ayarları dikkate al
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX") // Nokta (.) için standart format
        if let number = formatter.number(from: self) {
            return CLLocationDegrees(number.doubleValue)
        }
        return nil
    }
}
