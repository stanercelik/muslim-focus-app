//
//  LockMoodSelectionView.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import SwiftUI

struct LockMoodSelectionView: View {
    enum Stage {
        case level
        case tag
    }

    @ObservedObject var viewModel: OnboardingViewModel
    let stage: Stage
    @State private var relationshipSlider: Double = 2

    var body: some View {
        Group {
            switch stage {
            case .level:
                relationshipStep
            case .tag:
                tagSelectionStep
            }
        }
        .onAppear {
            if stage == .level {
                relationshipSlider = sliderValue(for: viewModel.lockMoodSelection.moodLevel)
                viewModel.selectLockMoodLevel(levelForSlider(relationshipSlider))
            }
        }
    }

    private var relationshipStep: some View {
        let selectedProfile = relationshipProfile(for: relationshipSlider)

        return ZStack {
            LinearGradient(
                colors: selectedProfile.background,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 22) {
                Spacer(minLength: 20)

                Text(localized("Allah ile ilişkin bugün nasıl?", "How's your relationship with Allah today?"))
                    .font(.system(size: 42, weight: .bold, design: .rounded))
                    .foregroundColor(.appTextOnPrimary)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.75)

                Text(selectedProfile.emoji)
                    .font(.system(size: 78))

                VStack(spacing: 14) {
                    Slider(value: $relationshipSlider, in: 0...4, step: 1)
                        .tint(.appTextOnPrimary)
                        .onChange(of: relationshipSlider) { _, newValue in
                            HapticManager.shared.impact(style: .soft)
                            viewModel.selectLockMoodLevel(levelForSlider(newValue))
                        }

                    Text(selectedProfile.title)
                        .font(.system(size: 31, weight: .bold, design: .rounded))
                        .foregroundColor(.appTextOnPrimary)
                        .textCase(.lowercase)

                    HStack {
                        Text(localized("çok kötü", "very bad"))
                        Spacer()
                        Text(localized("çok iyi", "very good"))
                    }
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(.appTextOnPrimary.opacity(0.85))
                }
                .padding(.horizontal, 6)

                Spacer()

                Button {
                    HapticManager.shared.impact(style: .medium)
                    viewModel.nextStep()
                } label: {
                    Text(localized("devam et", "continue"))
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundColor(selectedProfile.accent)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .fill(Color.appSurface)
                                .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 4)
                        )
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 62)
            .padding(.bottom, 34)
        }
    }

    private var tagSelectionStep: some View {
        ZStack {
            Color.appSurface.ignoresSafeArea()

            VStack(spacing: 20) {
                Text(localized("Şu an nasıl hissediyorsun?", "How do you feel right now?"))
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(.appTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(localized("Sana uygun dua/ayet akışı için bir kategori seç.", "Choose a category to get a matching dua/ayah flow."))
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(.appTextPrimary.opacity(0.62))
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 12) {
                    ForEach(MoodTag.allCases, id: \.self) { tag in
                        let style = tagStyle(for: tag)
                        MoodTagCard(
                            emoji: style.emoji,
                            title: style.title,
                            subtitle: style.subtitle,
                            tint: style.tint,
                            isSelected: viewModel.lockMoodSelection.moodTag == tag
                        ) {
                            HapticManager.shared.impact(style: .soft)
                            viewModel.selectLockMoodTag(tag)
                        }
                    }
                }

                Spacer()

                GradientButton(title: .continueButton, isEnabled: viewModel.canProceedFromMoodTag) {
                    viewModel.nextStep()
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 64)
            .padding(.bottom, 40)
        }
    }

    private func sliderValue(for level: MoodLevel?) -> Double {
        guard let level else { return 2 }
        switch level {
        case .low:
            return 4
        case .mid:
            return 2
        case .high:
            return 1
        }
    }

    private func levelForSlider(_ value: Double) -> MoodLevel {
        let index = Int(value.rounded())
        if index <= 1 {
            return .high
        }
        if index == 2 {
            return .mid
        }
        return .low
    }

    private func relationshipProfile(for value: Double) -> RelationshipProfile {
        let index = Int(value.rounded())
        let profiles: [RelationshipProfile] = [
            RelationshipProfile(
                title: localized("çok kötü", "very bad"),
                emoji: "😞",
                accent: .onboardingDangerRed,
                background: [Color.onboardingDangerRed.opacity(0.96), Color.onboardingDangerRed.opacity(0.75)]
            ),
            RelationshipProfile(
                title: localized("kötü", "bad"),
                emoji: "😕",
                accent: Color(red: 0.76, green: 0.43, blue: 0.15),
                background: [Color(red: 0.86, green: 0.52, blue: 0.18), Color(red: 0.73, green: 0.43, blue: 0.14)]
            ),
            RelationshipProfile(
                title: localized("orta", "okay"),
                emoji: "🙂",
                accent: Color(red: 0.17, green: 0.49, blue: 0.55),
                background: [Color(red: 0.23, green: 0.62, blue: 0.70), Color(red: 0.18, green: 0.48, blue: 0.56)]
            ),
            RelationshipProfile(
                title: localized("iyi", "good"),
                emoji: "😊",
                accent: .appPrimary,
                background: [Color.appPrimary.opacity(0.95), Color.appPrimaryPressed.opacity(0.78)]
            ),
            RelationshipProfile(
                title: localized("çok iyi", "great"),
                emoji: "😁",
                accent: .onboardingGold,
                background: [Color.onboardingGold.opacity(0.95), Color.onboardingGold.opacity(0.75)]
            ),
        ]
        let safeIndex = min(max(index, 0), profiles.count - 1)
        return profiles[safeIndex]
    }

    private func tagStyle(for tag: MoodTag) -> MoodTagStyle {
        switch tag {
        case .anxiety:
            return MoodTagStyle(
                emoji: "🫀",
                title: localized("Kaygı", "Anxiety"),
                subtitle: localized("Kalbi sakinleştir, Allah'a dayan.", "Calm your heart and rely on Allah."),
                tint: Color(red: 0.88, green: 0.44, blue: 0.37)
            )
        case .focus:
            return MoodTagStyle(
                emoji: "🎯",
                title: localized("Odak", "Focus"),
                subtitle: localized("Zihni topla, dağınıklıktan çık.", "Re-center and recover focus."),
                tint: Color(red: 0.33, green: 0.48, blue: 0.83)
            )
        case .gratitude:
            return MoodTagStyle(
                emoji: "🤍",
                title: localized("Şükür", "Gratitude"),
                subtitle: localized("Nimeti gör, hamdi artır.", "Strengthen your perspective with shukr."),
                tint: Color(red: 0.42, green: 0.67, blue: 0.43)
            )
        case .guilt:
            return MoodTagStyle(
                emoji: "🕊️",
                title: localized("Tevbe", "Repentance"),
                subtitle: localized("Rahmet kapısına yönel.", "Turn back with hope and istighfar."),
                tint: Color(red: 0.55, green: 0.42, blue: 0.70)
            )
        case .patience:
            return MoodTagStyle(
                emoji: "⛰️",
                title: localized("Sabır", "Patience"),
                subtitle: localized("Zorlukta sebat et.", "Hold steady through hardship."),
                tint: Color(red: 0.80, green: 0.56, blue: 0.21)
            )
        case .guidance:
            return MoodTagStyle(
                emoji: "🧭",
                title: localized("Hidayet", "Guidance"),
                subtitle: localized("Doğru yolu iste ve netleş.", "Seek clarity and right direction."),
                tint: Color(red: 0.22, green: 0.62, blue: 0.57)
            )
        }
    }

    private func localized(_ tr: String, _ en: String) -> String {
        viewModel.primaryLanguage == .tr ? tr : en
    }
}

private struct RelationshipProfile {
    let title: String
    let emoji: String
    let accent: Color
    let background: [Color]
}

private struct MoodTagStyle {
    let emoji: String
    let title: String
    let subtitle: String
    let tint: Color
}

private struct MoodTagCard: View {
    let emoji: String
    let title: String
    let subtitle: String
    let tint: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(emoji)
                    .font(.system(size: 24))

                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(.appTextPrimary)
                    Text(subtitle)
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundColor(.appTextPrimary.opacity(0.6))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundColor(tint)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.appSurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? tint : Color.clear, lineWidth: 2)
                    )
                    .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
            )
        }
    }
}

#Preview {
    LockMoodSelectionView(viewModel: OnboardingViewModel(), stage: .level)
}
