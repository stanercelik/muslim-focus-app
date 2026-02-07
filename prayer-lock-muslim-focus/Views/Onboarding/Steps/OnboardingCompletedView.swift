//
//  OnboardingCompletedView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showSettings = false
    
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
                Text(.onboardingCompletedTitle)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .foregroundColor(Color.appTextOnPrimary)
                
                // Alt metin
                Text(.onboardingCompletedMessage)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.appTextOnPrimary.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()

                VStack(spacing: 12) {
                    Text("Difficulty: \(viewModel.currentDifficultyMode.localizedDisplayText.capitalized)")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Color.appTextOnPrimary.opacity(0.75))

                    Button {
                        showSettings = true
                    } label: {
                        Text("Open difficulty settings")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color.appPrimary)
                            .padding(.horizontal, 18)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.appSurface)
                            )
                    }
                }

                // Dev note
                Text(.devModeOnboardingCompleted)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(Color.appTextOnPrimary.opacity(0.6))
                    .padding(.bottom, 50)
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsDifficultyView(viewModel: viewModel)
        }
    }
}

#Preview {
    OnboardingCompletedView(viewModel: OnboardingViewModel())
}
