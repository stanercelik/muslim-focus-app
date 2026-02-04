//
//  OnboardingViewModel.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var currentStep: OnboardingStep = .splash
    @Published var onboardingData: OnboardingData = OnboardingData()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showHowItWorksModal: Bool = false
    
    // MARK: - Computed Properties
    var progressValue: Double {
        currentStep.progressValue
    }
    
    var canProceedFromNameInput: Bool {
        !onboardingData.name.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    var canProceedFromGoalSelection: Bool {
        !onboardingData.selectedGoals.isEmpty && onboardingData.selectedGoals.count <= 3
    }
    
    var canProceedFromBlockerSelection: Bool {
        !onboardingData.blockers.isEmpty && onboardingData.blockers.count <= 3
    }
    
    var canProceedFromRootStruggle: Bool {
        onboardingData.rootStruggles.count <= 2
    }
    
    // MARK: - Navigation Methods
    func nextStep() {
        withAnimation(.easeInOut(duration: 0.3)) {
            moveToNextStep()
        }
    }
    
    func previousStep() {
        // Implementation for back navigation if needed
    }
    
    private func moveToNextStep() {
        switch currentStep {
        case .splash:
            currentStep = .problemFraming
        case .problemFraming:
            currentStep = .productPromise
        case .productPromise:
            currentStep = .nameInput
        case .nameInput:
            guard canProceedFromNameInput else { return }
            currentStep = .transition
        case .transition:
            currentStep = .ageRange
        case .ageRange:
            currentStep = .phoneUsage
        case .phoneUsage:
            currentStep = .phoneImpact
        case .phoneImpact:
            currentStep = .timeIntro
        case .timeIntro:
            currentStep = .goalSelection1
        case .goalSelection1:
            guard canProceedFromGoalSelection else { return }
            currentStep = .goalSelection2
        case .goalSelection2:
            currentStep = .thinkingBigger
        case .thinkingBigger:
            currentStep = .youreInRightPlace
        case .youreInRightPlace:
            currentStep = .prayerFrequency
        case .prayerFrequency:
            currentStep = .relationshipWithAllah
        case .relationshipWithAllah:
            currentStep = .mainBlockers
        case .mainBlockers:
            guard canProceedFromBlockerSelection else { return }
            currentStep = .deeperStruggles
        case .deeperStruggles:
            currentStep = .thankYou1
        case .thankYou1:
            currentStep = .thankYou2
        case .thankYou2:
            currentStep = .thankYou3
        case .thankYou3:
            currentStep = .madhhabSelection
        case .madhhabSelection:
            currentStep = .sexSelection
        case .sexSelection:
            currentStep = .howItWorksModal
        case .howItWorksModal:
            currentStep = .prayerIsPowerful
        case .prayerIsPowerful:
            currentStep = .planSummary
        case .planSummary:
            currentStep = .moodCheckIn1
        case .moodCheckIn1:
            currentStep = .moodCheckIn2
        case .moodCheckIn2:
            currentStep = .moodCheckIn3
        case .moodCheckIn3:
            currentStep = .guidedPrayer
        case .guidedPrayer:
            currentStep = .verseOfDay
        case .verseOfDay:
            currentStep = .congratulations
        case .congratulations:
            currentStep = .ratingPrompt
        case .ratingPrompt:
            currentStep = .streakScreen
        case .streakScreen:
            currentStep = .planBuilding
        case .planBuilding:
            currentStep = .planReady
        case .planReady:
            currentStep = .planDetails
        case .planDetails:
            currentStep = .commitment
        case .commitment:
            currentStep = .encouragement
        case .encouragement:
            currentStep = .faithSnapshot
        case .faithSnapshot:
            currentStep = .strengthsAreas
        case .strengthsAreas:
            currentStep = .screenTimePermission
        case .screenTimePermission:
            currentStep = .notificationPermission
        case .notificationPermission:
            currentStep = .socialProof
        case .socialProof:
            currentStep = .paywall
        case .paywall:
            currentStep = .completed
        case .completed:
            break
        }
    }
    
    // MARK: - Data Update Methods
    func updateName(_ name: String) {
        onboardingData.name = name
    }
    
    func selectAgeRange(_ ageRange: AgeRange) {
        onboardingData.ageRange = ageRange
    }
    
    func selectPhoneUsage(_ usage: PhoneUsageRange) {
        onboardingData.phoneUsageHours = usage
    }
    
    func toggleGoal(_ goal: UserGoal) {
        if onboardingData.selectedGoals.contains(goal) {
            onboardingData.selectedGoals.removeAll { $0 == goal }
        } else if onboardingData.selectedGoals.count < 3 {
            onboardingData.selectedGoals.append(goal)
        }
    }
    
    func selectBiggerVision(_ vision: BiggerVision) {
        onboardingData.biggerVision = vision
    }
    
    func updateIbadahFrequency(_ days: Int) {
        onboardingData.ibadahDaysPerWeek = max(0, min(7, days))
    }
    
    func selectSpiritualState(_ state: SpiritualState) {
        onboardingData.spiritualState = state
    }
    
    func toggleBlocker(_ blocker: Blocker) {
        if onboardingData.blockers.contains(blocker) {
            onboardingData.blockers.removeAll { $0 == blocker }
        } else if onboardingData.blockers.count < 3 {
            onboardingData.blockers.append(blocker)
        }
    }
    
    func toggleRootStruggle(_ struggle: RootStruggle) {
        if onboardingData.rootStruggles.contains(struggle) {
            onboardingData.rootStruggles.removeAll { $0 == struggle }
        } else if onboardingData.rootStruggles.count < 2 {
            onboardingData.rootStruggles.append(struggle)
        }
    }
    
    func selectMadhhab(_ madhhab: Madhhab) {
        onboardingData.madhhab = madhhab
    }
    
    func selectSex(_ sex: Sex) {
        onboardingData.sex = sex
    }
    
    func selectMood(_ mood: Mood) {
        onboardingData.mood = mood
    }
    
    func selectCommitment(_ commitment: CommitmentLevel) {
        onboardingData.commitment = commitment
    }
    
    // MARK: - Persistence
    func saveOnboardingData() async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            onboardingData.hasCompletedOnboarding = true
            // TODO: Save to UserDefaults or DataStore
            // await dataStore.save(onboardingData)
            
            // TODO: Track analytics event
            // analyticsService.track(.onboardingCompleted)
        } catch {
            errorMessage = "Veri kaydedilemedi: \(error.localizedDescription)"
        }
    }
}
