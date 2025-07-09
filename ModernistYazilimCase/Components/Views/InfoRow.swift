//
//  InfoRow.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 8.07.2025.
//
import SwiftUI
struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    @State private var isTapped = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.accentColor, .accentColor.opacity(0.7)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                )
                .padding(4)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                
                Text(value)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .scaleEffect(isTapped ? 0.98 : 1.0) // Tap animation
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isTapped)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .onTapGesture {
            withAnimation {
                isTapped = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isTapped = false
                }
            }
        }
    }
}

#Preview {
    InfoRow(icon: "envelope.fill", title: "Email", value: "developerburakgul@gmail.com")
        .padding()
}
