//
//  OnboardingDifficultyModeView.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import SwiftUI

struct OnboardingDifficultyModeView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        ZStack {
            Color.appSurface.ignoresSafeArea()

            VStack(spacing: 20) {
                Text(localized("İbadet akışının zorluk seviyesini seç", "Choose your prayer flow difficulty"))
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.appTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(localized("Bu seçim sadece içerik uzunluğunu ve yoğunluğunu etkiler. İstediğin zaman Ayarlar'dan değiştirebilirsin.", "This only affects content length and intensity. You can change it anytime in Settings."))
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.appTextPrimary.opacity(0.65))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)

                VStack(spacing: 12) {
                    ForEach(DifficultyMode.allCases, id: \.self) { mode in
                        DifficultyOptionRow(
                            title: title(for: mode),
                            subtitle: subtitle(for: mode),
                            isSelected: viewModel.currentDifficultyMode == mode
                        ) {
                            HapticManager.shared.impact(style: .soft)
                            viewModel.selectDifficultyMode(mode)
                            viewModel.saveOnboardingSnapshot()
                        }
                    }
                }
                .padding(.top, 8)

                Spacer()

                GradientButton(title: .continueButton, isEnabled: true) {
                    viewModel.nextStep()
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 64)
            .padding(.bottom, 40)
        }
    }

    private func title(for mode: DifficultyMode) -> String {
        switch mode {
        case .easy:
            return localized("Kolay", "Easy")
        case .medium:
            return localized("Orta", "Medium")
        case .hard:
            return localized("Zor", "Hard")
        }
    }

    private func subtitle(for mode: DifficultyMode) -> String {
        switch mode {
        case .easy:
            return localized("Kısa ve hafif akış. Başlamak için ideal.", "Short and light flow. Ideal for getting started.")
        case .medium:
            return localized("Dengeli akış. Ayet ve dua birlikte ilerler.", "Balanced flow with ayah and dua together.")
        case .hard:
            return localized("Daha uzun ve derin akış. Daha yoğun tefekkür için.", "Longer, deeper flow for more reflection.")
        }
    }

    private func localized(_ tr: String, _ en: String) -> String {
        viewModel.primaryLanguage == .tr ? tr : en
    }
}

private struct DifficultyOptionRow: View {
    let title: String
    let subtitle: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
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
                        .foregroundColor(.appPrimary)
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.appSurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? Color.appPrimary : Color.clear, lineWidth: 2)
                    )
                    .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 4)
            )
        }
    }
}

#Preview {
    OnboardingDifficultyModeView(viewModel: OnboardingViewModel())
}
