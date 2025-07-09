//
//  FavoritesView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var viewModel: FavoritesViewModel
    @EnvironmentObject var container: DependencyContainer
    
    var body: some View {
        NavigationStack {
            mainContent
                .task{
                    await viewModel.loadData()
                }
                .navigationTitle(TextKey.favoritesTitle.stringValue.capitalized)
                .navigationDestination(item: $viewModel.selectedUser) { user in
                    let viewModelFactory = ViewModelFactory(container: container)
                    UserDetailView(viewModel: viewModelFactory.makeUserDetailViewModel(user: user))
                        .toolbarVisibility(.hidden, for: .tabBar)
                        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
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
            if users.isEmpty {
                makeEmptyView()
            }else {
                makeView(from: users)
            }
            
        }
    }
    
    func makeView(from users: [User]) -> some View {
        List {
            ForEach(users, id: \.id) { user in
                UserCellView(user: user)
                    .padding(.vertical, 4)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    .onTapGesture {
                        viewModel.selectedUser = user
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.deleteFavorites(user: user)
                        } label: {
                            Label("", systemImage: "trash")
                                .labelStyle(.iconOnly)
                        }
                        
                    }
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 0)
    }
    
    func makeEmptyView() -> some View {
        ContentUnavailableView(
            TextKey.couldntFindFavoritesTitle.stringValue,
            systemImage: "magnifyingglass",
            description: Text(TextKey.couldntFindFavoritesDescription.stringValue)
        )
    }
}

#Preview {
    var container = DevPreview.shared.container
    FavoritesView(
        viewModel: ViewModelFactory(container: container)
            .makeFavoritesViewModel()
    )
    .previewEnvironment()
}
