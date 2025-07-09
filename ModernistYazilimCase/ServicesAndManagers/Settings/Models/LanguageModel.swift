//
//  LanguageModel.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 9.07.2025.
//
import Foundation

struct LanguageModel {
    let name: String
    let code: String
}

enum Language: Identifiable, CaseIterable, Equatable{
    var id: String {
        self.languageModel.name
    }
    
    case english
    case turkish
    
    var languageModel: LanguageModel {
        switch self {
        case .english:
            return LanguageModel(name: "English", code: "en")
        case .turkish:
            return LanguageModel(name: "Türkçe", code: "tr")
        }
    }
    static let defaultLanguageModel: LanguageModel = LanguageModel(name: "English", code: "en")
    

}
