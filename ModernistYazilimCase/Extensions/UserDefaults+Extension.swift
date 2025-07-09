//
//  Keys.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 9.07.2025.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let selectedLanguageCode = "selectedLanguageCode"
    }
    
    static var selectedLanguageCode: String {
        get {
            return standard.string(forKey: Keys.selectedLanguageCode) ?? Language.defaultLanguageModel.code
        } set {
            standard.set(newValue, forKey: Keys.selectedLanguageCode)
        }
    }
}

