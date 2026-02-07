//
//  OnboardingPrayerIsPowerfulView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 6.02.2026.
//

import SwiftUI

struct OnboardingPrayerIsPowerfulView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var progress: CGFloat = 0
    @State private var showHowItWorksDialog = false

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.appPrimary,
                    Color.appPrimary
                ]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer(minLength: 32)

                Text(.phoneImpactHeadline)
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundColor(Color.appTextOnPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                SpiritualGrowthCard(progress: progress)

                Text(.phoneImpactDescription)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.appTextOnPrimary.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Button(action: {
                    HapticManager.shared.impact(style: .medium)
                    viewModel.nextStep()
                }) {
                    Text(.phoneImpactHowItWorks)
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(Color.appTextOnPrimary.opacity(0.55))
                }
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 28)

                Spacer(minLength: 24)
            }
        }
        .overlay {
            if showHowItWorksDialog {
                Color.black.opacity(0.65)
                    .ignoresSafeArea()
                    .transition(.opacity)

                HowItWorksDialog(isPresented: $showHowItWorksDialog)
                    .environmentObject(viewModel)
                    .padding(.horizontal, 28)
                    .transition(.scale(scale: 0.96).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showHowItWorksDialog)
        .onAppear {
            progress = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                withAnimation(.easeInOut(duration: 0.35)) {
                    showHowItWorksDialog = true
                }
            }
        }
        .onChange(of: showHowItWorksDialog) { _, isPresented in
            guard isPresented == false else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                withAnimation(.easeInOut(duration: 3.6)) {
                    progress = 1
                }
            }
        }
    }
}

private struct SpiritualGrowthCard: View {
    let progress: CGFloat

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                Text(L10n.markdown("phone_impact_card_title"))
                    .font(.system(size: 22, weight: .bold, design: .rounded))

                Spacer()

                LogoPlaceholder()
            }

            HStack(spacing: 6) {
                Image(systemName: "xmark")
                    .font(.system(size: 11, weight: .heavy))
                    .foregroundColor(Color.onboardingDangerRed)
                Text(.phoneImpactSkippedPrayer)
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.onboardingDangerRed)
            }
            .padding(.top, -12)

            SpiritualGrowthChartView(progress: progress)
                .frame(height: 220)

            WeekLabels()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.appSurface)
                .shadow(color: Color.onboardingCardShadow, radius: 16, x: 0, y: 10)
        )
        .padding(.horizontal, 24)
    }
}

private struct LogoPlaceholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 14, style: .continuous)
            .fill(Color.appSurface2)
            .frame(width: 44, height: 44)
            .overlay(
                Image(systemName: "app.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.appPrimary)
            )
    }
}

private struct SpiritualGrowthChartView: View {
    let progress: CGFloat

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let baselineY = size.height * 0.92
            let goodPath = goodLinePath(in: size)
            let badPath = badLinePath(in: size)
            let greenPoints = goodLinePoints(in: size)
            let redPoints = badLinePoints(in: size)
            let endPoint = goodEndPoint(in: size)

            ZStack {
                goodFillPath(in: size, baselineY: baselineY)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.onboardingGold.opacity(0.35),
                                Color.onboardingGold.opacity(0.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .mask(alignment: .leading) {
                        Rectangle()
                            .frame(width: size.width * progress, height: size.height)
                    }

                badFillPath(in: size, baselineY: baselineY)
                    .fill(Color.onboardingDangerRed.opacity(0.18))
                    .mask(alignment: .leading) {
                        Rectangle()
                            .frame(width: size.width * progress, height: size.height)
                    }

                goodPath
                    .trim(from: 0, to: progress)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.appPrimary.opacity(0.35),
                                Color.appPrimary
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round)
                    )
                    .shadow(color: Color.appPrimary.opacity(0.2), radius: 6, x: 0, y: 2)

                badPath
                    .trim(from: 0, to: progress)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.onboardingDangerRed.opacity(0.35),
                                Color.onboardingDangerRed
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: 3.5, lineCap: .round, lineJoin: .round)
                    )
                    .shadow(color: Color.onboardingDangerRed.opacity(0.18), radius: 4, x: 0, y: 2)

                ForEach(Array(badTroughPoints(in: size).enumerated()), id: \.offset) { index, point in
                    if point.x <= size.width * progress {
                        if index == 2 {
                            VStack(spacing: 2) {
                                
                                Text(.phoneImpactPrayLater)
                                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color.onboardingDangerRed)
                                Spacer()
                                    .frame(height: 6)
                                Rectangle()
                                    .fill(Color.onboardingDangerRed)
                                    .frame(width: 3, height: 16)
                            }
                            .position(CGPoint(x: point.x, y: point.y - 36))
                        } else {
                            Image(systemName: "xmark")
                                .font(.system(size: 11, weight: .heavy))
                                .foregroundColor(Color.onboardingDangerRed)
                                .position(CGPoint(x: point.x, y: point.y - 16))
                        }
                    }
                }

                if endPoint.x <= size.width * progress {
                    Circle()
                        .fill(Color.appPrimary)
                        .frame(width: 10, height: 10)
                        .position(endPoint)
                }

                if let redEnd = redPoints.last, redEnd.x <= size.width * progress {
                    VStack(spacing: 36) {
                        HStack(){
                            Text(.phoneImpactDevilWon)
                                .font(.system(size: 11, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.onboardingDangerRed)
                            Spacer()
                                .frame(width: 4)
                        }
                        Circle()
                            .fill(Color.onboardingDangerRed)
                            .frame(width: 10, height: 10)
                    }
                    .position(CGPoint(x: redEnd.x, y: redEnd.y - 24))
                }

                if let greenStart = greenPoints.first, greenStart.x <= size.width * progress {
                    Circle()
                        .stroke(Color.appPrimary, lineWidth: 1.5)
                        .frame(width: 10, height: 10)
                        .position(greenStart)
                }

                if let redStart = redPoints.first, redStart.x <= size.width * progress {
                    Circle()
                        .stroke(Color.onboardingDangerRed, lineWidth: 1.5)
                        .frame(width: 10, height: 10)
                        .position(redStart)
                }
            }
            .drawingGroup()
        }
    }

    private func goodLinePath(in size: CGSize) -> Path {
        smoothPath(from: goodLinePoints(in: size))
    }

    private func goodFillPath(in size: CGSize, baselineY: CGFloat) -> Path {
        let points = goodLinePoints(in: size)
        var path = smoothPath(from: points)
        guard let first = points.first, let last = points.last else { return path }
        path.addLine(to: CGPoint(x: last.x, y: baselineY))
        path.addLine(to: CGPoint(x: first.x, y: baselineY))
        path.closeSubpath()
        return path
    }

    private func badLinePath(in size: CGSize) -> Path {
        smoothPath(from: badLinePoints(in: size))
    }

    private func badFillPath(in size: CGSize, baselineY: CGFloat) -> Path {
        let points = badLinePoints(in: size)
        var path = smoothPath(from: points)
        guard let first = points.first, let last = points.last else { return path }
        path.addLine(to: CGPoint(x: last.x, y: baselineY))
        path.addLine(to: CGPoint(x: first.x, y: baselineY))
        path.closeSubpath()
        return path
    }

    private func badLinePoints(in size: CGSize) -> [CGPoint] {
        [
            CGPoint(x: size.width * 0.08, y: size.height * 0.82),
            CGPoint(x: size.width * 0.16, y: size.height * 0.76),
            CGPoint(x: size.width * 0.24, y: size.height * 0.90),
            CGPoint(x: size.width * 0.32, y: size.height * 0.72),
            CGPoint(x: size.width * 0.40, y: size.height * 0.88),
            CGPoint(x: size.width * 0.48, y: size.height * 0.74),
            CGPoint(x: size.width * 0.56, y: size.height * 0.92),
            CGPoint(x: size.width * 0.64, y: size.height * 0.76),
            CGPoint(x: size.width * 0.72, y: size.height * 0.88),
            CGPoint(x: size.width * 0.80, y: size.height * 0.78),
            CGPoint(x: size.width * 0.88, y: size.height * 0.92)
        ]
    }

    private func badTroughPoints(in size: CGSize) -> [CGPoint] {
        let points = badLinePoints(in: size)
        return [
            points[2],
            points[4],
            points[6],
            points[8]
        ]
    }

    private func goodEndPoint(in size: CGSize) -> CGPoint {
        goodLinePoints(in: size).last ?? CGPoint(x: size.width * 0.88, y: size.height * 0.24)
    }

    private func goodLinePoints(in size: CGSize) -> [CGPoint] {
        [
            CGPoint(x: size.width * 0.08, y: size.height * 0.68),
            CGPoint(x: size.width * 0.20, y: size.height * 0.62),
            CGPoint(x: size.width * 0.32, y: size.height * 0.64),
            CGPoint(x: size.width * 0.44, y: size.height * 0.52),
            CGPoint(x: size.width * 0.56, y: size.height * 0.46),
            CGPoint(x: size.width * 0.68, y: size.height * 0.34),
            CGPoint(x: size.width * 0.78, y: size.height * 0.28),
            CGPoint(x: size.width * 0.90, y: size.height * 0.02)
        ]
    }

    private func smoothPath(from points: [CGPoint]) -> Path {
        var path = Path()
        guard points.count > 1 else { return path }
        path.move(to: points[0])

        for index in 0..<(points.count - 1) {
            let p0 = index > 0 ? points[index - 1] : points[index]
            let p1 = points[index]
            let p2 = points[index + 1]
            let p3 = index + 2 < points.count ? points[index + 2] : p2

            let control1 = CGPoint(
                x: p1.x + (p2.x - p0.x) / 6,
                y: p1.y + (p2.y - p0.y) / 6
            )
            let control2 = CGPoint(
                x: p2.x - (p3.x - p1.x) / 6,
                y: p2.y - (p3.y - p1.y) / 6
            )

            path.addCurve(to: p2, control1: control1, control2: control2)
        }

        return path
    }
}

private struct WeekLabels: View {
    var body: some View {
        HStack {
            Text(.phoneImpactWeek1)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appTextPrimary.opacity(0.6))

            Spacer()

            Text(.phoneImpactWeek2)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appTextPrimary.opacity(0.6))

            Spacer()

            Text(.phoneImpactWeek3)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appTextPrimary.opacity(0.6))
        }
        .padding(.horizontal, 8)
    }
}

private struct HowItWorksDialog: View {
    @Binding var isPresented: Bool
    @EnvironmentObject private var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 18) {
            HStack {
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        isPresented = false
                    }
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color.appTextPrimary.opacity(0.6))
                        .frame(width: 28, height: 28)
                        .background(
                            Circle()
                                .fill(Color.appSurface2)
                        )
                }
            }

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.appPrimary.opacity(0.1))
                .frame(width: 56, height: 56)
                .overlay(
                    Image(systemName: "lock.fill")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color.appPrimary)
                )

            Text(.prayerIsPowerfulDialogTitle)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundColor(Color.appTextPrimary)

            VStack(alignment: .leading, spacing: 14) {
                HowItWorksStep(index: 1, text: .prayerIsPowerfulDialogStep1)
                HowItWorksStep(index: 2, text: .prayerIsPowerfulDialogStep2)
                HowItWorksStep(index: 3, text: .prayerIsPowerfulDialogStep3)
            }

            Text(.prayerIsPowerfulDialogFooter)
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appTextPrimary.opacity(0.6))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 6)

            Button(action: {
                HapticManager.shared.impact(style: .medium)
                viewModel.nextStep()
            }) {
                Text(.prayerIsPowerfulDialogButton)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundColor(Color.appTextOnPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 16, style: .continuous)
                            .fill(Color.appPrimary)
                    )
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.appSurface)
                .shadow(color: Color.appPrimary.opacity(0.2), radius: 18, x: 0, y: 10)
        )
    }
}

private struct HowItWorksStep: View {
    let index: Int
    let text: LocalizedStringKey

    var body: some View {
        HStack(spacing: 12) {
            Text("\(index)")
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(Color.appTextOnPrimary)
                .frame(width: 28, height: 28)
                .background(
                    Circle()
                        .fill(Color.appPrimary)
                )

            Text(text)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundColor(Color.appTextPrimary)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
    }
}

#Preview {
    OnboardingPrayerIsPowerfulView(viewModel: OnboardingViewModel())
}
