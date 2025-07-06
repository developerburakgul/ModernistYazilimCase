//
//  UsersView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import SwiftUI

struct UsersView: View {
    @StateObject var viewModel: UsersViewModel
    var body: some View {
        NavigationStack {
            mainContent
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
                .onAppear {
                    viewModel.loadData()
                }
        case .loading:
            ProgressView()
        case .failed(let userError):
            ErrorView(model: userError)
        case .loaded(let value):
            Text(verbatim: value)
        }
    }
}

#Preview {
    let container = DevPreview.shared.container
    UsersView(
        viewModel:
            ViewModelFactory(container: container)
            .makeUsersViewModel()
    )
}
