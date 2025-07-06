//
//  DevPreview.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import Foundation
import SwiftUI



@MainActor
class DevPreview {
    static let shared = DevPreview()
    
    var container: DependencyContainer {
        let container = DependencyContainer()
        return container
    }
    init (){}
}

extension View {
    func previewEnvironment() -> some View {
        self.environmentObject(DevPreview.shared.container)
    }
}
