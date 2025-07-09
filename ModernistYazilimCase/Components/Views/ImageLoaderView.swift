//
//  ImageLoaderView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 9.07.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    let urlString: String?
    let size: CGFloat
    
    init(urlString: String?, size: CGFloat = 100) {
        self.urlString = urlString
        self.size = size
    }
    
    var body: some View {
        Group {
            if let urlString = urlString, let url = URL(string: urlString), !urlString.isEmpty {
                WebImage(url: url)
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.3))
                    .scaledToFill()
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .foregroundColor(.gray.opacity(0.5))
                    .scaledToFill()
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.white, lineWidth: 1))
        .shadow(radius: 3)
    }
}

#Preview {
    VStack(spacing: 20) {
        ImageLoaderView(urlString: "https://picsum.photos/200")
        ImageLoaderView(urlString: Constants.randomImage)
        ImageLoaderView(urlString: nil, size: 150)
        ImageLoaderView(urlString: "", size: 100)
    }
    .padding()
}

