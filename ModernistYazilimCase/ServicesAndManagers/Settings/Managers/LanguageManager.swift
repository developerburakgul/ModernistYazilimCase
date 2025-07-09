//
//  LanguageManager.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 9.07.2025.
//

import Foundation
@MainActor
protocol LanguageManagerProtocol {
    func setLanguage(_ language: Language)
    func getLanguage() -> Language
}

@MainActor
final class LanguageManager: ObservableObject, LanguageManagerProtocol {
    
    init() {
        let language = getLanguage()
        setLanguage(language)
    }
    
    func setLanguage(_ language: Language){
        UserDefaults.selectedLanguageCode = language.languageModel.code
        Bundle.setLanguage(UserDefaults.selectedLanguageCode)
    }
    
    func getLanguage() -> Language {
        let savedCode = UserDefaults.selectedLanguageCode
        let currentLanguage = Language.allCases.first(where: { $0.languageModel.code == savedCode }) ?? .english
        return currentLanguage
    }
    

    
}
