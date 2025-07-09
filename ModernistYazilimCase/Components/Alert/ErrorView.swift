//
//  ErrorView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import SwiftUI

struct ErrorView: View {
    let model: UserError
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text(model.title)
                .font(.title)
            Text(model.description)
        }
    }
}

#Preview {
    ErrorView(model: .init(title: "Error Title", description: "Error Description"))
}
