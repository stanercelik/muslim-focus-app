//
//  SettingsDifficultyView.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import SwiftUI

struct SettingsDifficultyView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appSurface.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Difficulty Mode")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.appTextPrimary)

                    Text("This affects card length and type distribution at lock time.")
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(.appTextPrimary.opacity(0.65))

                    VStack(spacing: 10) {
                        ForEach(DifficultyMode.allCases, id: \.self) { mode in
                            Button {
                                HapticManager.shared.impact(style: .soft)
                                viewModel.updateDifficultyFromSettings(mode)
                                viewModel.saveOnboardingSnapshot()
                            } label: {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(mode.localizedDisplayText.capitalized)
                                            .font(.system(size: 17, weight: .bold, design: .rounded))
                                        Text(detailText(for: mode))
                                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                                            .foregroundColor(.appTextPrimary.opacity(0.6))
                                    }
                                    Spacer()
                                    if viewModel.currentDifficultyMode == mode {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.appPrimary)
                                    }
                                }
                                .padding(14)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.appSurface)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 14)
                                                .stroke(viewModel.currentDifficultyMode == mode ? Color.appPrimary : Color.clear, lineWidth: 2)
                                        )
                                )
                            }
                        }
                    }

                    Spacer()
                }
                .padding(24)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func detailText(for mode: DifficultyMode) -> String {
        switch mode {
        case .easy:
            return "More short cards (xs/s), softer rhythm"
        case .medium:
            return "Balanced content length and type"
        case .hard:
            return "More deep cards (m/l), stronger dua focus"
        }
    }
}

#Preview {
    SettingsDifficultyView(viewModel: OnboardingViewModel())
}
