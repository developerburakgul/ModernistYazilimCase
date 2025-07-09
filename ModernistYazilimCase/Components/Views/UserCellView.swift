//
//  UserCellView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//

import SwiftUI

struct UserCellView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            ImageLoaderView(urlString: user.imageURLString, size: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(user.email)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(color: Color.black.opacity(0.08), radius: 6, x: 0, y: 3)
        )
        .padding(.horizontal, 8)

    }
}


#Preview {
    UserCellView(user: User.mock())
        .padding(16)
}
