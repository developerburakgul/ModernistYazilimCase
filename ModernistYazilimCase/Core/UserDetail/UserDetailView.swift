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
            .toolbar {
                Button {
                     viewModel.toggleFavorite()
                 } label: {
                     Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                         .foregroundColor(viewModel.isFavorite ? .red : .gray)
                         .frame(width: 40, height: 40)
                         .background(Color(.systemBackground))
                         .clipShape(Circle())
                         .shadow(radius: 4, x: 2, y: 2)
                 }
                 .padding(.trailing, 8)
                 .padding(.bottom, 4)
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
        case .loaded(let user):
            makeView(from: user)
        }
    }
    
    private func makeView(from user: User) -> some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                mapView(user: user)
                cirleImageAndNameView(user: user)
                contactInformationView(user: user)
                addressView(user: user)
                Spacer()
            }
        }
        .ignoresSafeArea(edges: .top)
    }
    
    private func mapView(user: User) -> some View {
        MapView(location: user.address.geo.getCLLocationCoordinate2D())
            .frame(height: 300)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.separator), lineWidth: 1)
            )
    }
    
    private func cirleImageAndNameView(user: User) -> some View {
        VStack(spacing: 12) {
            CircleImage(name: user.name)
                .frame(width: 125, height: 125)
                .overlay(
                    Circle()
                        .stroke(Color(.systemBackground), lineWidth: 4)
                        .frame(width: 126, height: 126)
                )
                .offset(y: -75)
                .padding(.bottom, -75)
            
            Text(user.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(user.userName)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
    
    private func contactInformationView(user: User) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(TextKey.contactInformation.stringValue)
                .font(.headline)
                .padding(.top, 8)
                .padding(.horizontal, 8)
            
            InfoRow(icon: "envelope.fill", title: TextKey.email.stringValue, value: user.email)
                .onTapGesture {
                    if let url = URL(string: "mailto:\(user.email)") {
                        UIApplication.shared.open(url)
                    }
                }
            
            InfoRow(icon: "phone.fill", title: TextKey.phone.stringValue, value: user.phone)
                .onTapGesture {
                    if let url = URL(string: "tel:\(user.phone.replacingOccurrences(of: " ", with: ""))") {
                        UIApplication.shared.open(url)
                    }
                }
            
            InfoRow(icon: "globe", title: TextKey.website.stringValue, value: user.website)
                .onTapGesture {
                    if let url = URL(string: "https://\(user.website)") {
                        UIApplication.shared.open(url)
                    }
                }
        }
        .padding()

    }
    
    private func addressView(user: User) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(TextKey.address.stringValue)
                .font(.headline)
                .padding(.top, 8)
                .padding(.horizontal, 8)
            
            InfoRow(icon: "mappin.and.ellipse", title: TextKey.street.stringValue, value: user.address.street)
            InfoRow(icon: "building.2.fill", title: TextKey.suite.stringValue, value: user.address.suite)
            InfoRow(icon: "house.fill", title: TextKey.city.stringValue, value: user.address.city)
            InfoRow(icon: "signpost.right.fill", title: TextKey.zipCode.stringValue, value: user.address.zipcode)
        }
        .padding()
    }
    
    private func companyCardView(user: User) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(TextKey.company.stringValue)
                .font(.headline)
                .padding(.top, 8)
                .padding(.horizontal, 8)
            
            InfoRow(icon: "briefcase.fill", title: TextKey.name.stringValue, value: user.company.name)
            InfoRow(icon: "quote.bubble.fill", title: TextKey.catchPhrase.stringValue, value: user.company.catchPhrase)
            InfoRow(icon: "chart.bar.fill", title: TextKey.business.stringValue, value: user.company.bs)
        }
        .padding()
    }

}


#Preview {
    let container = DevPreview.shared.container
    NavigationStack {
        UserDetailView(viewModel: ViewModelFactory(container: container).makeUserDetailViewModel(user: User.mock()))
            .toolbarBackgroundVisibility(.hidden, for: .navigationBar)
    }
    
    
}
