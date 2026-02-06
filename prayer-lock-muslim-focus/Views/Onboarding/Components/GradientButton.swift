//
//  GradientButton.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct GradientButton: View {
    let title: LocalizedStringKey
    let isEnabled: Bool
    let action: () -> Void
    
    @State private var scale: CGFloat = 1.0
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                scale = 0.95
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    scale = 1.0
                }
            }
            action()
        }) {
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color.appTextOnPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    Group {
                        if isEnabled {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.appPrimary,
                                    Color.appPrimaryPressed
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        } else {
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.appStroke,
                                    Color.appStroke
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        }
                    }
                )
                .cornerRadius(16)
        }
        .disabled(!isEnabled)
        .scaleEffect(scale)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isEnabled)
    }
}

#Preview {
    VStack(spacing: 20) {
        GradientButton(title: .continueButton, isEnabled: true, action: {})
        GradientButton(title: .continueButton, isEnabled: false, action: {})
    }
    .padding()
}
