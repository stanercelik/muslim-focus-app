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
                    CustomProgressBar(progress: viewModel.progressValue)
                }
                
                // Main content
                currentStepView
                    .transition(.opacity)
            }
        }
        .preferredColorScheme(.light)
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
        case .goalSelection1:
            OnboardingGoalSelectionView(viewModel: viewModel)
        case .thinkingBigger:
            OnboardingBiggerVisionView(viewModel: viewModel)
        case .youreInRightPlace:
            OnboardingYoureInRightPlaceView(viewModel: viewModel)
        case .hadithScreen:
            OnboardingHadithView(viewModel: viewModel)
        case .prayerFrequency:
            OnboardingPrayerFrequencyView(viewModel: viewModel)
        case .relationshipWithAllah:
            OnboardingRelationshipView(viewModel: viewModel)
        case .mainBlockers:
            OnboardingBlockersView(viewModel: viewModel)
        case .deeperStruggles:
            OnboardingRootStrugglesView(viewModel: viewModel)
        case .madhhabSelection:
            OnboardingMadhhabView(viewModel: viewModel)
        case .sexSelection:
            OnboardingSexView(viewModel: viewModel)
        case .onboardingSummary:
            OnboardingSummaryView(viewModel: viewModel)
        case .prayerIsPowerful:
            OnboardingPrayerIsPowerfulView(viewModel: viewModel)
        case .completed:
            OnboardingCompletedView(viewModel: viewModel)
        default:
            Text(L10n.text("onboarding_coming_soon", viewModel.currentStep.rawValue))
                .foregroundColor(Color.appTextPrimary)
        }
    }
    
    private var backgroundColor: Color {
        switch viewModel.currentStep {
        case .splash, .youreInRightPlace, .encouragement, .planReady, .completed, .onboardingSummary:
            return .appPrimary
        default:
            return .appSurface
        }
    }
    
    private var shouldShowProgressBar: Bool {
        // Progress bar sadece goalSelection1'den itibaren gösterilir
        switch viewModel.currentStep {
        case .splash, .problemFraming, .productPromise, .nameInput, .transition, .ageRange, .phoneUsage, .phoneImpact, .timeIntro, .youreInRightPlace:
            return false
        case .hadithScreen, .howItWorksModal, .ratingPrompt, .prayerIsPowerful, .onboardingSummary:
            return false
        default:
            return true
        }
    }
}

#Preview("Onboarding") {
    OnboardingContainerView()
}
