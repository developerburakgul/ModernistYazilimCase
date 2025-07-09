//
//  Tabs.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation


enum Tabs {
    case users
    case favorites
    
    var selectedImageName: String {
        switch self {
        case .users:
            return "person.3.fill"
        case .favorites:
            return "heart.fill"
        }
    }
    
    var nonSelectedImageName: String {
        switch self {
        case .users:
            return "person.3"
        case .favorites:
            return "heart"
        }
    }
    var title: String {
        switch self {
        case .users:
            return TextKey.users.stringValue.capitalized
        case .favorites:
            return TextKey.favorites.stringValue.capitalized
        }
    }
}
