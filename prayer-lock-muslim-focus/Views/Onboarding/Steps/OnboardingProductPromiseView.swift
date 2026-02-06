//
//  OnboardingProductPromiseView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingProductPromiseView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showTitle1 = false
    @State private var showFeature1 = false
    @State private var showFeature2 = false
    @State private var showFeature3 = false
    @State private var showTapToContinue = false
    @State private var currentAnimationStep = 0
    @State private var buttonDelayTask: Task<Void, Never>?
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Ana başlık
                Text(.productPromiseTitle)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.appTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .opacity(showTitle1 ? 1.0 : 0.0)
                    .offset(y: showTitle1 ? 0 : 20)
                
                Spacer()
                    .frame(height: 40)
                
                // Özellikler
                VStack(alignment: .leading, spacing: 16) {
                    Text(.productPromiseFeature1)
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showFeature1 ? 1.0 : 0.0)
                        .offset(y: showFeature1 ? 0 : 20)
                    
                    Text(.productPromiseFeature2)
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showFeature2 ? 1.0 : 0.0)
                        .offset(y: showFeature2 ? 0 : 20)
                    
                    Text(.productPromiseFeature3)
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showFeature3 ? 1.0 : 0.0)
                        .offset(y: showFeature3 ? 0 : 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
                
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
            showTitle1 = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if currentAnimationStep == 0 {
                currentAnimationStep = 1
                withAnimation(.easeOut(duration: 1.0)) {
                    showFeature1 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            if currentAnimationStep == 1 {
                currentAnimationStep = 2
                withAnimation(.easeOut(duration: 1.0)) {
                    showFeature2 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            if currentAnimationStep == 2 {
                currentAnimationStep = 3
                withAnimation(.easeOut(duration: 1.0)) {
                    showFeature3 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            if currentAnimationStep == 3 {
                currentAnimationStep = 4
                startButtonDelay()
            }
        }
    }
    
    private func startButtonDelay() {
        buttonDelayTask?.cancel()
        buttonDelayTask = Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
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
                showTitle1 = true
            }
            currentAnimationStep = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showFeature1 = true
                }
            }
            
        case 1:
            withAnimation(.easeOut(duration: 0.3)) {
                showFeature1 = true
            }
            currentAnimationStep = 2
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showFeature2 = true
                }
            }
            
        case 2:
            withAnimation(.easeOut(duration: 0.3)) {
                showFeature2 = true
            }
            currentAnimationStep = 3
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showFeature3 = true
                }
            }
            
        case 3:
            withAnimation(.easeOut(duration: 0.3)) {
                showFeature3 = true
            }
            currentAnimationStep = 4
            startButtonDelay()
            
        case 4:
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
    OnboardingProductPromiseView(viewModel: OnboardingViewModel())
}
