//
//  UsersView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import SwiftUI

struct UsersView: View {
    @StateObject var viewModel: UsersViewModel
    @EnvironmentObject var container: DependencyContainer
    @State var searchQuery: String = ""
    
    var body: some View {
        NavigationStack {
            mainContent
                .task{
                    await viewModel.loadData()
                }
                .navigationTitle(TextKey.users.stringValue.capitalized)
                .searchable(
                    text: $searchQuery,
                    placement: .navigationBarDrawer(displayMode: .automatic),
                    prompt: TextKey.enterNameForSearchText.stringValue
                )
                .onChange(of: searchQuery) { oldValue, newValue in
                    viewModel.userDidSearch(searchQuery)
                }
                .navigationDestination(item: $viewModel.selectedUser) { user in
                    let viewModelFactory = ViewModelFactory(container: container)
                    UserDetailView(viewModel: viewModelFactory.makeUserDetailViewModel(user: user))
                        .toolbarVisibility(.hidden, for: .tabBar)
                        .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
                }
                .sheet(isPresented: $viewModel.shouldGoToSettings){
                    let viewModelFactory = ViewModelFactory(container: container)
                    SettingsView(viewModel: viewModelFactory.makeSettingsViewModel())
//                        .presentationDetents([.fraction(0.5)])
                }
                .toolbar {
                    Button {
                        viewModel.clickSettingsButton()
                    } label: {
                        Image(systemName: "gear")
                            .foregroundStyle(UIColor.label.toColor)
                    }
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
    
    private func makeView(from users: [User]) -> some View {
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
                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
                        Button {
                            viewModel.addFavorites(user: user)
                        } label: {
                            Label("", systemImage: "heart")
                            .labelStyle(.iconOnly)
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        if viewModel.isFavoriteUser(user) {
                            Button(role: .destructive) {
                                viewModel.deleteFavorites(user: user)
                            } label: {
                                Label("", systemImage: "trash")
                                    .labelStyle(.iconOnly)
                            }
                        }
                        
                    }
            }
        }
        .listStyle(.plain)
        .environment(\.defaultMinListRowHeight, 0)
    }
    
 
}

#Preview {
    let container = DevPreview.shared.container
    let viewModelFactory = ViewModelFactory(container: container)
    UsersView(
        viewModel:
            viewModelFactory
            .makeUsersViewModel()
    )
    .previewEnvironment()
}
