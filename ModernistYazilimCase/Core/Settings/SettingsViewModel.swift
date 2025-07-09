//
//  UsersViewModel.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation


@MainActor
final class SettingsViewModel: ObservableObject {
    private let interactor: SettingsInteractorProtocol
    @Published private(set) var state: LoadingState<Bool> = .idle
    @Published var selectedLanguage: Language = Language.english
    
    private(set) var allLanguages: [Language] = Language.allCases
    
    init(interactor: SettingsInteractorProtocol) {
        self.interactor = interactor
    }
    
    func loadData() async {
        state = .loading
        selectedLanguage = interactor.getLanguage()
        state = .loaded(true)
    }
    
    func changeLanguage(_ language: Language) {
        interactor.setLanguage(language)
        selectedLanguage = language
    }
}
