//
//  OnboardingContainerView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingContainerView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Progress bar
                if shouldShowProgressBar {
                    ProgressView(value: viewModel.progressValue)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.appPrimary))
                        .frame(height: 2)
                }
                
                // Main content
                currentStepView
                    .transition(.opacity)
            }
        }
        .preferredColorScheme(.medium)
    }
    
    // MARK: - Computed Views
    
    @ViewBuilder
    private var currentStepView: some View {
        switch viewModel.currentStep {
        case .splash:
            OnboardingSplashView(viewModel: viewModel)
        case .problemFraming:
            OnboardingProblemFramingView(viewModel: viewModel)
        case .productPromise:
            OnboardingProductPromiseView(viewModel: viewModel)
        case .nameInput:
            OnboardingNameInputView(viewModel: viewModel)
        case .transition:
            OnboardingTransitionView(viewModel: viewModel)
        case .ageRange:
            OnboardingAgeRangeView(viewModel: viewModel)
        case .phoneUsage:
            OnboardingPhoneUsageView(viewModel: viewModel)
        case .phoneImpact:
            OnboardingPhoneImpactView(viewModel: viewModel)
        case .timeIntro:
            OnboardingTimeIntroView(viewModel: viewModel)
        default:
            Text("Coming soon: \(viewModel.currentStep.rawValue)")
                .foregroundColor(Color.appTextPrimary)
        }
    }
    
    private var backgroundColor: Color {
        switch viewModel.currentStep {
        case .splash, .youreInRightPlace, .encouragement, .planReady:
            return .appPrimary
        default:
            return .appSurface
        }
    }
    
    private var shouldShowProgressBar: Bool {
        // Progress bar sadece 8. ekrandan (goalSelection1) itibaren gösterilir
        switch viewModel.currentStep {
        case .splash, .problemFraming, .productPromise, .nameInput, .transition, .ageRange, .phoneUsage, .phoneImpact, .timeIntro:
            return false
        case .howItWorksModal, .ratingPrompt:
            return false
        default:
            return true
        }
    }
}

#Preview("Onboarding") {
    OnboardingContainerView()
}
