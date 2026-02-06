//
//  OnboardingSummaryView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 6.02.2026.
//

import SwiftUI

struct OnboardingSummaryView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var showGoalCard = false
    @State private var showStateCard = false
    @State private var showBlockersCard = false
    @State private var showFooter = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.appPrimary,
                    Color.appPrimaryPressed
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text(L10n.text("onboarding_summary_title", displayName))
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundColor(Color.appTextOnPrimary)
                            .padding(.top, 28)
                            .padding(.horizontal, 24)
                            .opacity(showTitle ? 1.0 : 0.0)
                            .offset(y: showTitle ? 0 : 16)

                        Text(.onboardingSummarySubtitle)
                            .font(.system(size: 17, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.appTextOnPrimary.opacity(0.9))
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal, 24)
                            .opacity(showSubtitle ? 1.0 : 0.0)
                            .offset(y: showSubtitle ? 0 : 16)

                        VStack(spacing: 18) {
                            SummaryCard(
                                label: .onboardingSummaryGoalLabel,
                                content: goalSummary,
                                isList: true
                            )
                            .opacity(showGoalCard ? 1.0 : 0.0)
                            .offset(y: showGoalCard ? 0 : 16)

                            SummaryCard(
                                label: .onboardingSummaryStateLabel,
                                content: stateSummary
                            )
                            .opacity(showStateCard ? 1.0 : 0.0)
                            .offset(y: showStateCard ? 0 : 16)

                            SummaryListCard(
                                label: .onboardingSummaryBlockersLabel,
                                items: blockersSummary
                            )
                            .opacity(showBlockersCard ? 1.0 : 0.0)
                            .offset(y: showBlockersCard ? 0 : 16)
                        }
                        .padding(.horizontal, 16)
                    }
                }

                VStack(spacing: 12) {
                    Text(L10n.text("onboarding_summary_footer", displayName))
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.appTextOnPrimary.opacity(0.9))
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)

                    Button(action: {
                        HapticManager.shared.impact(style: .medium)
                        viewModel.nextStep()
                    }) {
                        Text(.onboardingSummaryContinue)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color.appPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .fill(Color.appSurface)
                            )
                    }
                }
                .opacity(showFooter ? 1.0 : 0.0)
                .offset(y: showFooter ? 0 : 16)
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, 28)
            }
        }
        .onAppear {
            viewModel.saveOnboardingSnapshot()
            startAnimationSequence()
        }
    }

    private var displayName: String {
        let trimmed = viewModel.onboardingData.name.trimmingCharacters(in: .whitespaces)
        return trimmed.isEmpty ? L10n.text("onboarding_summary_default_name") : trimmed
    }

    private var goalSummary: String {
        let goals = viewModel.onboardingData.selectedGoals
        guard goals.isEmpty == false else {
            return L10n.text("onboarding_summary_goal_empty")
        }
        return goals.map { $0.displayText }.joined(separator: "\n")
    }

    private var stateSummary: String {
        if let state = viewModel.onboardingData.spiritualState {
            return state.displayText
        }
        return L10n.text("onboarding_summary_state_empty")
    }

    private var blockersSummary: [String] {
        let blockers = viewModel.onboardingData.blockers
        guard blockers.isEmpty == false else {
            return [L10n.text("onboarding_summary_blockers_empty")]
        }
        return blockers.prefix(3).map { $0.displayText }
    }

    private func startAnimationSequence() {
        withAnimation(.easeOut(duration: 0.9).delay(0.5)) {
            showTitle = true
        }

        withAnimation(.easeOut(duration: 0.9).delay(1.5)) {
            showSubtitle = true
        }

        withAnimation(.easeOut(duration: 0.9).delay(3.5)) {
            showGoalCard = true
        }

        withAnimation(.easeOut(duration: 0.9).delay(4.5)) {
            showStateCard = true
        }

        withAnimation(.easeOut(duration: 0.9).delay(5.5)) {
            showBlockersCard = true
        }

        withAnimation(.easeOut(duration: 1.0).delay(6.5)) {
            showFooter = true
        }
    }
}

private struct SummaryCard: View {
    let label: LocalizedStringKey
    let content: String
    var isList: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appPrimary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.appPrimary.opacity(0.12))
                )

            Text(content)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(Color.appTextPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .lineSpacing(isList ? 6 : 0)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.appSurface)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct SummaryListCard: View {
    let label: LocalizedStringKey
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(label)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appPrimary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(Color.appPrimary.opacity(0.12))
                )

            VStack(alignment: .leading, spacing: 10) {
                ForEach(items.indices, id: \.self) { index in
                    HStack(alignment: .center, spacing: 10) {
                        Circle()
                            .fill(Color.appPrimary)
                            .frame(width: 6, height: 6)
                        Text(items[index])
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.appTextPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.appSurface)
                .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    OnboardingSummaryView(viewModel: OnboardingViewModel())
}
