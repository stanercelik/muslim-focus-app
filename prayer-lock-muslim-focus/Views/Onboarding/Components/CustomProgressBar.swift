//
//  CustomProgressBar.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct CustomProgressBar: View {
    let progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background (gri)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.appStroke.opacity(0.3))
                    .frame(height: 6)
                
                // Progress (yeşil gradient)
                RoundedRectangle(cornerRadius: 8)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.appPrimary.opacity(0.8),
                                Color.appPrimary
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geometry.size.width * progress, height: 6)
            }
        }
        .frame(height: 6)
        .padding(.horizontal, 24)
        .padding(.top, 16)
    }
}

#Preview {
    VStack(spacing: 20) {
        CustomProgressBar(progress: 0.3)
        CustomProgressBar(progress: 0.5)
        CustomProgressBar(progress: 0.8)
    }
    .padding()
}
