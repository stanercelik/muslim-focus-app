//
//  OnboardingHowItWorksExperienceView.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import SwiftUI

struct OnboardingHowItWorksExperienceView: View {
    private enum Stage {
        case mood
        case practice
    }

    @ObservedObject var viewModel: OnboardingViewModel
    @State private var stage: Stage = .mood
    @State private var sliderValue: Double = 1
    @State private var visibleLineCount: Int = 0
    @State private var revealTask: Task<Void, Never>?

    private let revealInterval: UInt64 = 1_200_000_000

    private var selectedMood: OnboardingViewModel.HowItWorksMood {
        switch Int(sliderValue.rounded()) {
        case 0:
            return .bad
        case 2:
            return .great
        default:
            return .good
        }
    }

    private var prayerLines: [String] {
        viewModel.howItWorksPrayerLines()
    }

    private var isPracticeComplete: Bool {
        prayerLines.isEmpty == false && visibleLineCount >= prayerLines.count
    }

    var body: some View {
        ZStack {
            if stage == .mood {
                moodBackground(for: selectedMood)
            } else {
                Color.appSurface
            }
        }
        .ignoresSafeArea()
        .overlay {
            VStack(spacing: 0) {
                if stage == .mood {
                    moodStep
                } else {
                    practiceStep
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 58)
            .padding(.bottom, 34)
        }
        .onAppear {
            stage = .mood
            visibleLineCount = 0
            sliderValue = sliderValueForMood(viewModel.howItWorksMood)
            viewModel.prepareHowItWorksDemoCard(for: selectedMood)
        }
        .onChange(of: sliderValue) { _, _ in
            viewModel.prepareHowItWorksDemoCard(for: selectedMood)
        }
        .onChange(of: stage) { _, newStage in
            guard newStage == .practice else {
                revealTask?.cancel()
                return
            }
            startReveal()
        }
        .onChange(of: viewModel.howItWorksDemoCard?.id) { _, _ in
            guard stage == .practice else { return }
            startReveal()
        }
        .onDisappear {
            revealTask?.cancel()
        }
    }

    private var moodStep: some View {
        VStack(spacing: 22) {
            Text("Muslim Focus")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.appTextOnPrimary.opacity(0.9))
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 10)

            Text("How's your relationship with Allah today?")
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundColor(.appTextOnPrimary)
                .multilineTextAlignment(.center)

            Text(emojiForMood(selectedMood))
                .font(.system(size: 78))

            VStack(spacing: 14) {
                Slider(value: $sliderValue, in: 0...2, step: 1)
                    .tint(.appTextOnPrimary)

                Text(labelForMood(selectedMood))
                    .font(.system(size: 31, weight: .bold, design: .rounded))
                    .foregroundColor(.appTextOnPrimary)
                    .textCase(.lowercase)
            }

            Spacer()

            Button(action: {
                HapticManager.shared.impact(style: .medium)
                viewModel.setHowItWorksMood(selectedMood)
                withAnimation(.easeInOut(duration: 0.28)) {
                    stage = .practice
                }
            }) {
                Text("continue")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(moodAccentColor(for: selectedMood))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color.appSurface)
                            .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 4)
                    )
            }
        }
    }

    private var practiceStep: some View {
        VStack(spacing: 18) {
            VStack(spacing: 8) {
                Text("let's pray")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.appTextPrimary)

                Text("Muslim Focus picks a short prayer flow from your mood.")
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.appTextPrimary.opacity(0.55))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
            }

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    if prayerLines.isEmpty {
                        ProgressView()
                            .tint(.appPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        ForEach(Array(prayerLines.enumerated()), id: \.offset) { index, line in
                            if index < visibleLineCount {
                                Text(line)
                                    .font(index == 0
                                          ? .system(size: 26, weight: .bold, design: .rounded)
                                          : .system(size: 21, weight: .semibold, design: .rounded))
                                    .foregroundColor(.appTextPrimary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                            }
                        }
                    }
                }
                .padding(.vertical, 10)
                .animation(.easeOut(duration: 0.32), value: visibleLineCount)
            }

            Button(action: {
                HapticManager.shared.impact(style: .medium)
                viewModel.nextStep()
            }) {
                Text("i've prayed today 🙏")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(isPracticeComplete ? .appTextOnPrimary : .appTextPrimary.opacity(0.5))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 18)
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(isPracticeComplete ? Color.appPrimary : Color.appStroke)
                    )
            }
            .disabled(isPracticeComplete == false)
        }
    }

    private func startReveal() {
        revealTask?.cancel()
        visibleLineCount = 0

        let lines = prayerLines
        guard lines.isEmpty == false else { return }

        revealTask = Task {
            for index in lines.indices {
                let delay = index == 0 ? UInt64(450_000_000) : revealInterval
                try? await Task.sleep(nanoseconds: delay)
                guard Task.isCancelled == false else { return }

                await MainActor.run {
                    withAnimation(.easeOut(duration: 0.35)) {
                        visibleLineCount = index + 1
                    }
                }
            }
        }
    }

    private func sliderValueForMood(_ mood: OnboardingViewModel.HowItWorksMood) -> Double {
        switch mood {
        case .bad:
            return 0
        case .good:
            return 1
        case .great:
            return 2
        }
    }

    private func labelForMood(_ mood: OnboardingViewModel.HowItWorksMood) -> String {
        switch mood {
        case .bad:
            return "bad"
        case .good:
            return "good"
        case .great:
            return "great"
        }
    }

    private func emojiForMood(_ mood: OnboardingViewModel.HowItWorksMood) -> String {
        switch mood {
        case .bad:
            return "😕"
        case .good:
            return "🙂"
        case .great:
            return "😊"
        }
    }

    private func moodAccentColor(for mood: OnboardingViewModel.HowItWorksMood) -> Color {
        switch mood {
        case .bad:
            return .onboardingDangerRed
        case .good:
            return .appPrimary
        case .great:
            return .onboardingGold
        }
    }

    @ViewBuilder
    private func moodBackground(for mood: OnboardingViewModel.HowItWorksMood) -> some View {
        switch mood {
        case .bad:
            LinearGradient(
                colors: [Color.onboardingDangerRed.opacity(0.94), Color.onboardingDangerRed.opacity(0.72)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .good:
            LinearGradient(
                colors: [Color.appPrimary.opacity(0.95), Color.appPrimaryPressed.opacity(0.76)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case .great:
            LinearGradient(
                colors: [Color.onboardingGold.opacity(0.95), Color.onboardingGold.opacity(0.74)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}

#Preview {
    OnboardingHowItWorksExperienceView(viewModel: OnboardingViewModel())
}
