//
//  UsersInteractorProtocol.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation

@MainActor
protocol SettingsInteractorProtocol {
    func setLanguage(_ language: Language)
    func getLanguage() -> Language
}

extension CoreInteractor: SettingsInteractorProtocol {}


