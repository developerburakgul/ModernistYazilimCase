//
//  UserDetailView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//

import SwiftUI

struct UserDetailView: View {
    @StateObject var viewModel: UserDetailViewModel
    var body: some View {
        mainContent
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
        case .loaded(let user):
            makeView(from: user)
        }
    }
    
    func makeView(from user: User) -> some View {
        VStack(alignment: .center, spacing: 10) {
            MapView(location: user.address.geo.getCLLocationCoordinate2D())
                .frame(height: 200)
            
            CircleImage(name: user.name)
                .frame(width: 200, height: 200)
                .offset(y: -100)
                
            Spacer()
        }
        
    }
}


#Preview {
    let container = DevPreview.shared.container
    UserDetailView(viewModel: ViewModelFactory(container: container).makeUserDetailViewModel(user: User.mock()))
}
