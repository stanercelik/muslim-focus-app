//
//  OnboardingProblemFramingView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingProblemFramingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showMainTitle = false
    @State private var showLine1 = false
    @State private var showLine2 = false
    @State private var showLine3 = false
    @State private var showLine4 = false
    @State private var showTapToContinue = false
    @State private var currentAnimationStep = 0
    @State private var buttonDelayTask: Task<Void, Never>?
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Ana soru - Allah (cc) özel formatla
                VStack(alignment: .leading, spacing: 0) {
                    (Text("Bazen telefonun, ")
                        .foregroundColor(Color.appTextPrimary) +
                    Text("Rabbimiz'den")
                        .foregroundColor(Color.appPrimary)
                        .fontWeight(.bold) +
                    Text(" ")
                        .foregroundColor(Color.appTextPrimary) +
                    Text("(cc)")
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                        .foregroundColor(Color.appTextPrimary.opacity(0.6)) +
                    Text(" daha fazla ilgi istediğini hissediyor musun?")
                        .foregroundColor(Color.appTextPrimary))
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
                .opacity(showMainTitle ? 1.0 : 0.0)
                .offset(y: showMainTitle ? 0 : 20)
                
                Spacer()
                    .frame(height: 40)
                
                // Alt metin - her satır ayrı fade in
                VStack(alignment: .leading, spacing: 12) {
                    Text("Yalnız değilsin, bu çağın en büyük imtihanı bu.")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showLine1 ? 1.0 : 0.0)
                        .offset(y: showLine1 ? 0 : 20)
                    
                    Text("Bildirimler ve sonsuz kaydırmalar,")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showLine2 ? 1.0 : 0.0)
                        .offset(y: showLine2 ? 0 : 20)
                    
                    Text("kalbindeki o asıl huzurdan seni")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showLine3 ? 1.0 : 0.0)
                        .offset(y: showLine3 ? 0 : 20)
                    
                    Text("yavaşça uzaklaştırabiliyor.")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .opacity(showLine4 ? 1.0 : 0.0)
                        .offset(y: showLine4 ? 0 : 20)
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
            showMainTitle = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            if currentAnimationStep == 0 {
                currentAnimationStep = 1
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine1 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            if currentAnimationStep == 1 {
                currentAnimationStep = 2
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine2 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
            if currentAnimationStep == 2 {
                currentAnimationStep = 3
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine3 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8.0) {
            if currentAnimationStep == 3 {
                currentAnimationStep = 4
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine4 = true
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9.0) {
            if currentAnimationStep == 4 {
                currentAnimationStep = 5
                startButtonDelay()
            }
        }
    }
    
    private func startButtonDelay() {
        buttonDelayTask?.cancel()
        buttonDelayTask = Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
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
                showMainTitle = true
            }
            currentAnimationStep = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine1 = true
                }
            }
            
        case 1:
            withAnimation(.easeOut(duration: 0.3)) {
                showLine1 = true
            }
            currentAnimationStep = 2
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine2 = true
                }
            }
            
        case 2:
            withAnimation(.easeOut(duration: 0.3)) {
                showLine2 = true
            }
            currentAnimationStep = 3
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine3 = true
                }
            }
            
        case 3:
            withAnimation(.easeOut(duration: 0.3)) {
                showLine3 = true
            }
            currentAnimationStep = 4
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showLine4 = true
                }
            }
            
        case 4:
            withAnimation(.easeOut(duration: 0.3)) {
                showLine4 = true
            }
            currentAnimationStep = 5
            startButtonDelay()
            
        case 5:
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
    OnboardingProblemFramingView(viewModel: OnboardingViewModel())
}
