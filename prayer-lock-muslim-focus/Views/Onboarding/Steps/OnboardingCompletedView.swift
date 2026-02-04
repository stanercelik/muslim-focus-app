//
//  OnboardingCompletedView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            // Yeşil gradient arka plan
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.appPrimary,
                    Color.appPrimaryPressed
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                
                // Checkmark icon
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color.appTextOnPrimary)
                
                // Başlık
                Text("Harika!")
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(Color.appTextOnPrimary)
                
                // Alt metin
                Text("Onboarding tamamlandı. \nDevam eden ekranlar yakında gelecek.")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.appTextOnPrimary.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                // Dev note
                Text("[DEV MODE: Onboarding tamamlandı]")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(Color.appTextOnPrimary.opacity(0.6))
                    .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    OnboardingCompletedView(viewModel: OnboardingViewModel())
}
