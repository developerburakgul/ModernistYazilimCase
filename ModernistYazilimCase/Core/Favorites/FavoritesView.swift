//
//  FavoritesView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    @Previewable @EnvironmentObject var container: DependencyContainer
    FavoritesView(
        viewModel: ViewModelFactory(container: container)
            .makeFavoritesViewModel()
    )
}
