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
    @State private var showSubtext = false
    @State private var showTapToContinue = false
    @State private var currentAnimationStep = 0
    @State private var buttonDelayTask: Task<Void, Never>?
    
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
            
            // [DEV] Button - Sol üst köşe
            VStack {
                HStack {
                    Button(action: {
                        viewModel.currentStep = .onboardingSummary
                    }) {
                        Text(.devBadge)
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(Color.appTextOnPrimary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.black.opacity(0.2))
                            )
                    }
                    .padding(.leading, 16)
                    .padding(.top, 50)
                    
                    Spacer()
                }
                Spacer()
            }
            
            VStack {
                Spacer()
                
                VStack(spacing: 16) {
                    // "Selamun Aleyküm" yazısı
                    Text(.greeting)
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(Color.appTextOnPrimary)
                        .opacity(showGreeting ? 1.0 : 0.0)
                    
                    Spacer()
                        .frame(height: 4)
                    
                    // Alt metin
                    Text(.journeyBismillah)
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .foregroundColor(Color.appTextOnPrimary.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .opacity(showSubtext ? 1.0 : 0.0)
                }
                
                Spacer()
                
                // Tap to continue - sağ alt köşe
                HStack {
                    Spacer()
                    Button(action: {
                        HapticManager.shared.impact(style: .medium)
                        viewModel.nextStep()
                    }) {
                        HStack(spacing: 6) {
                            Text(.tapToContinue)
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 13, weight: .bold))
                        }
                        .foregroundColor(Color.appTextOnPrimary)
                    }
                    .opacity(showTapToContinue ? 1.0 : 0.0)
                    .padding(.trailing, 24)
                    .padding(.bottom, 50)
                }
            }
        }
        .onTapGesture {
            handleTapToSkip()
        }
        .onAppear {
            startAnimationSequence()
        }
    }
    
    private func startAnimationSequence() {
        // Greeting
        withAnimation(.easeOut(duration: 1.2).delay(0.5)) {
            showGreeting = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            if currentAnimationStep == 0 {
                currentAnimationStep = 1
                withAnimation(.easeOut(duration: 1.0)) {
                    showSubtext = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
            if currentAnimationStep == 1 {
                currentAnimationStep = 2
                startButtonDelay()
            }
        }
    }
    
    private func startButtonDelay() {
        buttonDelayTask?.cancel()
        buttonDelayTask = Task {
            try? await Task.sleep(nanoseconds: 700_000_000)
            await MainActor.run {
                withAnimation(.easeOut(duration: 1.0)) {
                    showTapToContinue = true
                }
            }
        }
    }
    
    private func handleTapToSkip() {
        switch currentAnimationStep {
        case 0:
            withAnimation(.easeOut(duration: 0.3)) {
                showGreeting = true
            }
            currentAnimationStep = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showSubtext = true
                }
            }
            
        case 1:
            withAnimation(.easeOut(duration: 0.3)) {
                showSubtext = true
            }
            currentAnimationStep = 2
            startButtonDelay()
            
        case 2:
            // Buton delay sürecindeyse hiçbir şey yapma
            if showTapToContinue {
                HapticManager.shared.impact(style: .medium)
                viewModel.nextStep()
            }
            
        default:
            break
        }
    }
}

#Preview {
    OnboardingSplashView(viewModel: OnboardingViewModel())
}
