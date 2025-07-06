//
//  TabBarView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 6.07.2025.
//

import SwiftUI

struct TabBarView: View {
    @State var selectedTab: Tabs = . users
    var body: some View {
        TabView(selection: $selectedTab){
            
            UsersView()
                .tabItem {
                    Label(
                        Tabs.users.title,
                        systemImage: selectedTab == .users ? Tabs.users.selectedImageName : Tabs.users.nonSelectedImageName
                    )
                }
                .tag(Tabs.users)
            
            FavoritesView()
                .tabItem {
                    Label(
                        Tabs.favorites.title,
                        systemImage: selectedTab == .favorites ? Tabs.favorites.selectedImageName : Tabs.favorites.nonSelectedImageName
                    )

                }
                .tag(Tabs.favorites)
        }
    }
}

#Preview {
    TabBarView()
}
