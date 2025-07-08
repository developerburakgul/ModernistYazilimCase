//
//  CircleImageView.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//

import SwiftUI

struct CircleImage: View {
    let name: String
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(1))
            
            Text(name.prefix(1))
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(UIColor.label.toColor)
        }
        .overlay {
            Circle().stroke(UIColor.white.toColor.opacity(0.5), lineWidth: 1)
        }
        .shadow(radius: 7)
    }
}


#Preview {
    CircleImage(name: "Burak")
        .frame(width: 250, height: 250)
        
}
