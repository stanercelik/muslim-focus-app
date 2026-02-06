//
//  OnboardingTransitionView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingTransitionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showLine1 = false
    @State private var showLine2 = false
    @State private var showTapToContinue = false
    @State private var currentAnimationStep = 0
    @State private var buttonDelayTask: Task<Void, Never>?
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 12) {
                    Text(L10n.text("transition_greeting", viewModel.onboardingData.name))
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showLine1 ? 1.0 : 0.0)
                        .offset(y: showLine1 ? 0 : 20)
                    
                    Text(.transitionMessage)
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showLine2 ? 1.0 : 0.0)
                        .offset(y: showLine2 ? 0 : 20)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Tap to continue
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
                        .foregroundColor(Color.appPrimary)
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
        withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
            showLine1 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if currentAnimationStep == 0 {
                currentAnimationStep = 1
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine2 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            if currentAnimationStep == 1 {
                currentAnimationStep = 2
                startButtonDelay()
            }
        }
    }
    
    private func startButtonDelay() {
        buttonDelayTask?.cancel()
        buttonDelayTask = Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            await MainActor.run {
                withAnimation(.easeOut(duration: 1.5)) {
                    showTapToContinue = true
                }
            }
        }
    }
    
    private func handleTapToSkip() {
        switch currentAnimationStep {
        case 0:
            withAnimation(.easeOut(duration: 0.3)) {
                showLine1 = true
            }
            currentAnimationStep = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine2 = true
                }
            }
            
        case 1:
            withAnimation(.easeOut(duration: 0.3)) {
                showLine2 = true
            }
            currentAnimationStep = 2
            startButtonDelay()
            
        case 2:
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
    OnboardingTransitionView(viewModel: OnboardingViewModel())
}
