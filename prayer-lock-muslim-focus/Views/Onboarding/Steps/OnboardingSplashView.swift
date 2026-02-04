//
//  OnboardingSplashView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingSplashView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showGreeting = false
    @State private var showTapToContinue = false
    
    var body: some View {
        ZStack {
            // Turuncu gradient arka plan
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.52, blue: 0.27),  // #FF8545 (açık turuncu)
                    Color(red: 1.0, green: 0.416, blue: 0.169)  // #FF6A2B (koyu turuncu)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                // "selam" yazısı - merkeze yakın
                Text("selam")
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .opacity(showGreeting ? 1.0 : 0.0)
                
                Spacer()
                
                // Tap to continue - sağ alt köşe
                HStack {
                    Spacer()
                    Button(action: {
                        HapticManager.shared.impact(style: .light)
                        viewModel.nextStep()
                    }) {
                        HStack(spacing: 6) {
                            Text("tap to continue")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 13, weight: .bold))
                        }
                        .foregroundColor(.white)
                    }
                    .opacity(showTapToContinue ? 1.0 : 0.0)
                    .padding(.trailing, 24)
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            // "selam" yazısı yavaşça fade in - daha uzun bekleme
            withAnimation(.easeOut(duration: 1.2).delay(0.5)) {
                showGreeting = true
            }
            
            // "tap to continue" daha sonra fade in - daha uzun bekleme
            withAnimation(.easeOut(duration: 1.0).delay(2.5)) {
                showTapToContinue = true
            }
        }
        .onTapGesture {
            // Ekrana tap'te de geçiş yap
            HapticManager.shared.impact(style: .light)
            viewModel.nextStep()
        }
    }
}

#Preview {
    OnboardingSplashView(viewModel: OnboardingViewModel())
}
