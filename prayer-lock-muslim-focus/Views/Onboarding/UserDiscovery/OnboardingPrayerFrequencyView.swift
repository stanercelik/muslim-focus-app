//
//  OnboardingPrayerFrequencyView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingPrayerFrequencyView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var showSlider = false
    @State private var showButton = false
    @State private var sliderValue: Double = 0
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Başlık
                Text(.userDiscoveryPrayerFrequencyTitle)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.appTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .padding(.top, 64)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .minimumScaleFactor(0.7)
                    .opacity(showTitle ? 1.0 : 0.0)
                    .offset(y: showTitle ? 0 : 20)
                
                Spacer()
                
                // Slider alanı
                VStack(spacing: 32) {
                    // Gün göstergesi - Rolling Counter
                    VStack(spacing: 8) {
                        RollingCounter(value: Int(sliderValue))
                            .foregroundColor(Color.appPrimary)
                        
                        Text(Int(sliderValue) == 1 ? .userDiscoveryPrayerFrequencyDaySingular : .userDiscoveryPrayerFrequencyDayPlural)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(Color.appTextPrimary.opacity(0.6))
                    }
                    
                    // Slider with tick marks
                    VStack(spacing: 8) {
                        // Tick marks
                        GeometryReader { geometry in
                            let totalWidth = geometry.size.width
                            let spacing = totalWidth / 7
                            
                            ZStack(alignment: .leading) {
                                // Background line
                                Rectangle()
                                    .fill(Color.appStroke.opacity(0.3))
                                    .frame(height: 2)
                                
                                // Active line
                                Rectangle()
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color.appPrimary.opacity(0.8),
                                                Color.appPrimary
                                            ]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: CGFloat(sliderValue / 7) * totalWidth, height: 4)
                                
                                // Tick marks (circles)
                                HStack(spacing: 0) {
                                    ForEach(0..<8) { index in
                                        Circle()
                                            .fill(Int(sliderValue) >= index ? Color.appPrimary : Color.appStroke)
                                            .frame(width: 12, height: 12)
                                            .frame(width: index == 0 ? 0 : spacing, alignment: .leading)
                                    }
                                }
                                
                                // Custom thumb
                                Circle()
                                    .fill(Color.appPrimary)
                                    .frame(width: 24, height: 24)
                                    .shadow(color: Color.appPrimary.opacity(0.3), radius: 8, x: 0, y: 4)
                                    .offset(x: CGFloat(sliderValue / 7) * totalWidth - 12)
                                
                                // Slider (invisible)
                                Slider(
                                    value: $sliderValue,
                                    in: 0...7,
                                    step: 1
                                )
                                .accentColor(.clear)
                                .onChange(of: sliderValue) { _, newValue in
                                    HapticManager.shared.impact(style: .medium)
                                    viewModel.updateIbadahFrequency(Int(newValue))
                                }
                                .opacity(0.01)
                            }
                        }
                        .frame(height: 44)
                        
                        // Min-Max labels (daha yakın)
                        HStack {
                            Text("0")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.appTextPrimary.opacity(0.5))
                            
                            Spacer()
                            
                            Text("7")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.appTextPrimary.opacity(0.5))
                        }
                    }
                    .padding(.horizontal, 40)
                }
                .opacity(showSlider ? 1.0 : 0.0)
                .offset(y: showSlider ? 0 : 20)
                
                Spacer()
                    .frame(minHeight: 20)
                
                // Continue button
                GradientButton(
                    title: .continueButton,
                    isEnabled: true,
                    action: {
                        HapticManager.shared.impact(style: .medium)
                        viewModel.nextStep()
                    }
                )
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
                .opacity(showButton ? 1.0 : 0.0)
            }
        }
        .onAppear {
            sliderValue = Double(viewModel.onboardingData.ibadahDaysPerWeek)
            
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                showTitle = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(2.0)) {
                showSlider = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(3.5)) {
                showButton = true
            }
        }
    }
}

// MARK: - Rolling Counter
struct RollingCounter: View {
    let value: Int
    
    var body: some View {
        Text("\(value)")
            .font(.system(size: 72, weight: .bold, design: .rounded))
            .contentTransition(.numericText(value: Double(value)))
            .animation(.smooth(duration: 0.3), value: value)
    }
}

#Preview {
    OnboardingPrayerFrequencyView(viewModel: OnboardingViewModel())
}
