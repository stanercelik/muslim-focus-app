//
//  OnboardingTimeIntroView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingTimeIntroView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showLine1 = false
    @State private var showLine2 = false
    @State private var showLine3 = false
    @State private var showTapToContinue = false
    @State private var currentAnimationStep = 0
    @State private var buttonDelayTask: Task<Void, Never>?
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Metin
                VStack(alignment: .leading, spacing: 32) {
                    Text("Bu döngüyü berekete çevirebiliriz.")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showLine1 ? 1.0 : 0.0)
                        .offset(y: showLine1 ? 0 : 20)
                    
                    // Rabbimize (cc) ile
                    VStack(alignment: .leading, spacing: 4) {
                        (Text("Günde sadece ")
                            .foregroundColor(Color.appTextPrimary)
                            .font(.system(size: 28, weight: .semibold, design: .rounded)) +
                        Text("5 dakikanı")
                            .foregroundColor(Color.appPrimary)
                            .font(.system(size: 28, weight: .semibold, design: .rounded))
                            .fontWeight(.bold) +
                        Text(" Rabbimize ")
                            .foregroundColor(Color.appTextPrimary).font(.system(size: 28, weight: .semibold, design: .rounded)) +
                        Text("(cc)")
                            .font(.system(size: 22))
                            .foregroundColor(Color.appTextPrimary.opacity(0.6))
                            .fontWeight(.medium)) +
                        Text(" ayırıp vaktini mühürlemeye var mısın?")
                            .foregroundColor(Color.appTextPrimary)
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                    }
                    .opacity(showLine2 ? 1.0 : 0.0)
                    .offset(y: showLine2 ? 0 : 20)
                    
                    Spacer()
                        .frame(height: 32)
                    
                    Text("Şimdi senin için manevi bir plan yapalım.")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showLine3 ? 1.0 : 0.0)
                        .offset(y: showLine3 ? 0 : 20)
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
                            Text("devam etmek için dokun")
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if currentAnimationStep == 0 {
                currentAnimationStep = 1
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine2 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            if currentAnimationStep == 1 {
                currentAnimationStep = 2
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine3 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
            if currentAnimationStep == 2 {
                currentAnimationStep = 3
                startButtonDelay()
            }
        }
    }
    
    private func startButtonDelay() {
        buttonDelayTask?.cancel()
        buttonDelayTask = Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine3 = true
                }
            }
            
        case 2:
            withAnimation(.easeOut(duration: 0.3)) {
                showLine3 = true
            }
            currentAnimationStep = 3
            startButtonDelay()
            
        case 3:
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
    OnboardingTimeIntroView(viewModel: OnboardingViewModel())
}
