//
//  OnboardingYoureInRightPlaceView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingYoureInRightPlaceView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showPage = false
    @State private var showCard1 = false
    @State private var showCard2 = false
    @State private var showCard3 = false
    @State private var showSummary = false
    @State private var scrollProxy: ScrollViewProxy?
    private let topContentPadding: CGFloat = 72

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.appPrimary
                .ignoresSafeArea()

            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {
                        VStack(spacing: 24) {
                            RightPlaceCard(
                                title: .youreInRightPlaceCard1Title,
                                bodyText: .youreInRightPlaceCard1Body,
                                rotationDegrees: -2,
                                shadowColor: Color.appPrimary.opacity(0.32),
                                isVisible: showCard1
                            )
                            .id("card1")

                            RightPlaceCard(
                                title: .youreInRightPlaceCard2Title,
                                bodyText: .youreInRightPlaceCard2Body,
                                rotationDegrees: 2,
                                shadowColor: Color.black.opacity(0.12),
                                isVisible: showCard2
                            )
                            .id("card2")

                            RightPlaceCard(
                                title: .youreInRightPlaceCard3Title,
                                bodyText: .youreInRightPlaceCard3Body,
                                rotationDegrees: -2,
                                shadowColor: Color.black.opacity(0.12),
                                isVisible: showCard3
                            )
                            .id("card3")
                        }

                        RightPlaceSummaryCard(isVisible: showSummary)
                            .id("summary")
                    }
                    .padding(.top, topContentPadding)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    .onAppear {
                        scrollProxy = proxy
                    }
                }
                .safeAreaInset(edge: .bottom) {
                    bottomSection
                }
            }

            topEdgeShadow

            backButton
        }
        .opacity(showPage ? 1.0 : 0.0)
        .onAppear {
            startAnimationSequence()
        }
    }

    private var backButton: some View {
        Button(action: {
            HapticManager.shared.impact(style: .medium)
            withAnimation(.easeInOut(duration: 0.3)) {
                viewModel.currentStep = .thinkingBigger
            }
        }) {
            Image(systemName: "chevron.left")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(Color.appPrimary)
                .frame(width: 44, height: 44)
                .background(
                    Circle()
                        .fill(.ultraThinMaterial)
                        .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 6)
                )
        }
        .padding(.top, 12)
        .padding(.leading, 20)
    }

    private var topEdgeShadow: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.appPrimary.opacity(1),
                Color.appPrimary.opacity(0.7),
                Color.appPrimary.opacity(0.0)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(height: 140)
        .blur(radius: 6)
        .ignoresSafeArea(edges: .top)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .allowsHitTesting(false)
    }

    private var bottomSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(.youreInRightPlaceFooterTitle)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundColor(Color.appSurface)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -3)
                .lineLimit(nil)
                .minimumScaleFactor(0.85)
                .fixedSize(horizontal: false, vertical: true)

            Text(.youreInRightPlaceFooterBody)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(Color.appSurface.opacity(0.9))
                .lineLimit(nil)
                .minimumScaleFactor(0.9)
                .fixedSize(horizontal: false, vertical: true)

            Button(action: {
                HapticManager.shared.impact(style: .medium)
                viewModel.nextStep()
            }) {
                Text(.continueButton)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.appPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .fill(Color.appSurface)
                            .shadow(color: Color.appPrimary.opacity(0.3), radius: 12, x: 0, y: 6)
                    )
            }
            .padding(.top, 12)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.top, 24)
        .padding(.bottom, 34)
        .background(
            ZStack {
                Color.appPrimary
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.black.opacity(0.22),
                        Color.clear
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            }
            .ignoresSafeArea(edges: .bottom)
        )
        .frame(maxWidth: .infinity, alignment: .bottom)
    }

    private func startAnimationSequence() {
        withAnimation(.easeOut(duration: 0.6)) {
            showPage = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.75, blendDuration: 0.2)) {
                showCard1 = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.75, blendDuration: 0.2)) {
                showCard2 = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.75, blendDuration: 0.2)) {
                showCard3 = true
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            withAnimation(.easeOut(duration: 0.8)) {
                showSummary = true
            }
            withAnimation(.easeInOut(duration: 1.1)) {
                scrollProxy?.scrollTo("summary", anchor: .top)
            }
        }
    }
}

private struct RightPlaceCard: View {
    let title: LocalizedStringKey
    let bodyText: LocalizedStringKey
    let rotationDegrees: Double
    let shadowColor: Color
    let isVisible: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appTextPrimary)

            Text(bodyText)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color.appTextPrimary.opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.appSurface)
                .shadow(color: shadowColor, radius: 12, x: 0, y: 6)
        )
        .opacity(isVisible ? 1.0 : 0.0)
        .scaleEffect(isVisible ? 1.0 : 0.96)
        .offset(y: isVisible ? 0 : 24)
        .rotationEffect(.degrees(rotationDegrees))
    }
}

private struct RightPlaceSummaryCard: View {
    let isVisible: Bool

    var body: some View {
        VStack(spacing: 8) {
            Text(.youreInRightPlaceSummaryLabel)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appTextPrimary.opacity(0.5))

            Text(.youreInRightPlaceSummaryTitle)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appTextPrimary)
                .multilineTextAlignment(.center)

            Text(.youreInRightPlaceSummaryStat)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appPrimary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.appSurface)
                .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 4)
        )
        .opacity(isVisible ? 1.0 : 0.0)
        .offset(y: isVisible ? 0 : 24)
    }
}

#Preview {
    OnboardingYoureInRightPlaceView(viewModel: OnboardingViewModel())
}
