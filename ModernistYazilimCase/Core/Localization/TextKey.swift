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
    case enterNameForSearchText = "Enter name for search..."
    case contactInformation = "Contact Information"
    case email = "Email"
    case phone = "Phone"
    case website = "Website"
    case address = "Address"
    case street = "Street"
    case suite = "Suite"
    case city = "City"
    case zipCode = "Zipcode"
    case name = "Name"
    case catchPhrase = "Catch Phrase"
    case business = "Business"
    case company = "Company"
    
    var stringValue: String {
        return self.rawValue.stringValue
    }
}

extension LocalizedStringResource {
    var stringValue: String {
        return NSLocalizedString(self.key, tableName: nil,value: self.key, comment: "")
    }
}
