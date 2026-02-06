//
//  OnboardingNameInputView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingNameInputView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @FocusState private var isTextFieldFocused: Bool
    @State private var showHeader = false
    @State private var showTitle = false
    @State private var showInput = false
    @State private var showButton = false
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                Spacer()
                
                // Header
                VStack(spacing: 12) {
                    Text(.getToKnowYou)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(Color.appTextPrimary.opacity(0.5))
                        .textCase(.uppercase)
                        .tracking(2)
                        .opacity(showHeader ? 1.0 : 0.0)
                        .offset(y: showHeader ? 0 : 20)
                    
                    Text(.nameQuestion)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(Color.appTextPrimary)
                        .multilineTextAlignment(.center)
                        .opacity(showTitle ? 1.0 : 0.0)
                        .offset(y: showTitle ? 0 : 20)
                }
                .padding(.horizontal, 24)
                
                // Input field
                VStack(spacing: 16) {
                    TextField("", text: Binding(
                        get: { viewModel.onboardingData.name },
                        set: { viewModel.updateName($0) }
                    ), prompt: Text(.nameInputPlaceholder).font(.system(size: 22, weight: .bold, design: .rounded)).foregroundColor(Color.appTextPrimary.opacity(0.3)))
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(Color.appTextPrimary)
                    .multilineTextAlignment(.center)
                    .focused($isTextFieldFocused)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.appInputBG)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.appStroke, lineWidth: 1)
                            )
                    )
                    .padding(.horizontal, 32)
                }
                .opacity(showInput ? 1.0 : 0.0)
                .offset(y: showInput ? 0 : 20)
                
                Spacer()
                
                // Continue button
                GradientButton(
                    title: .continueButton,
                    isEnabled: viewModel.canProceedFromNameInput,
                    action: {
                        HapticManager.shared.impact(style: .medium)
                        isTextFieldFocused = false
                        viewModel.nextStep()
                    }
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
                .opacity(showButton ? 1.0 : 0.0)
            }
        }
        .onAppear {
            // Animasyonlar sırayla
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                showHeader = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(1.5)) {
                showTitle = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(2.5)) {
                showInput = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(3.5)) {
                showButton = true
            }
            
            // Auto-focus the text field
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                isTextFieldFocused = true
            }
        }
    }
}

#Preview {
    OnboardingNameInputView(viewModel: OnboardingViewModel())
}
