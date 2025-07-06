//
//  Dependencies.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation


@MainActor
struct Dependencies {
    let container: DependencyContainer
    //MARK: - MANAGERS
    
    init() {
        self.container = DependencyContainer()
    }
}
