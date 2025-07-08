//
//  UsersView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import SwiftUI

struct UsersView: View {
    @StateObject var viewModel: UsersViewModel
    @State var searchQuery: String = ""
    var body: some View {
        NavigationStack {
            mainContent
                .task{
                    await viewModel.loadData()
                }
                .navigationTitle(TextKey.users.stringValue.uppercased())
                .searchable(
                    text: $searchQuery,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: TextKey.enterNameForSearchText.stringValue
                )
                .onChange(of: searchQuery) { oldValue, newValue in
                    viewModel.userDidSearch(searchQuery)
                }
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        switch viewModel.state {
        case .idle:
            Color.clear
        case .loading:
            ProgressView()
        case .failed(let userError):
            ErrorView(model: userError)
        case .loaded(let users):
            makeView(from: users)
        }
    }
    
    func makeView(from users: [User]) -> some View {
        ScrollView {
            ForEach(users, id: \.id) { user in
                UserCellView(user: user)
                    .padding(4)
            }
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
