//
//  TextKey.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation


enum TextKey: LocalizedStringResource {
    case users = "users"
    case favorites = "favorites"
    
    var stringValue: String {
        return self.rawValue.stringValue
    }
}

extension LocalizedStringResource {
    var stringValue: String {
        return NSLocalizedString(self.key, tableName: nil,value: self.key, comment: "")
    }
}
