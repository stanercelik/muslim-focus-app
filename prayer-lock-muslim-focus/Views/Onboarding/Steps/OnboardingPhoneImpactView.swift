//
//  OnboardingPhoneImpactView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingPhoneImpactView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showLine1 = false
    @State private var showLine2 = false
    @State private var showLine3 = false
    @State private var showLine4 = false
    @State private var showTapToContinue = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Hesaplama sonuçları
                VStack(alignment: .leading, spacing: 16) {
                    // Yıllık saat
                    Text("\(viewModel.onboardingData.name), bu yıl \(Text("\(yearlyHours) saat").foregroundColor(Color("AccentColor")).fontWeight(.bold)) telefonunda geçireceksin")
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine1 ? 1.0 : 0.0)
                        .offset(y: showLine1 ? 0 : 20)
                    
                    Spacer()
                        .frame(height: 24)
                    
                    // Günlük eşdeğer
                    Text("bu yılda \(Text("\(daysEquivalent) gün").foregroundColor(Color("AccentColor")).fontWeight(.bold))")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine2 ? 1.0 : 0.0)
                        .offset(y: showLine2 ? 0 : 20)
                    
                    
                    // Ömür boyu
                    Text("ya da ömrün boyunca \(Text("\(lifetimeYears) yıl ediyor").foregroundColor(Color("AccentColor")).fontWeight(.bold))...")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine3 ? 1.0 : 0.0)
                        .offset(y: showLine3 ? 0 : 20)
                    
                    Spacer()
                        .frame(height: 8)
                    
                    // Soru
                    Text("bunun ne kadarı seni \(Text("Allah'a").foregroundColor(Color("AccentColor")).fontWeight(.bold)) yaklaştırıyor?")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine4 ? 1.0 : 0.0)
                        .offset(y: showLine4 ? 0 : 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
                
                Spacer()
                
                // Tap to continue
                HStack {
                    Spacer()
                    Button(action: {
                        HapticManager.shared.impact(style: .light)
                        viewModel.nextStep()
                    }) {
                        HStack(spacing: 6) {
                            Text("tap to continue")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 13, weight: .bold))
                        }
                        .foregroundColor(Color("AccentColor"))
                    }
                    .opacity(showTapToContinue ? 1.0 : 0.0)
                    .padding(.trailing, 24)
                    .padding(.bottom, 50)
                }
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                showLine1 = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(3.5)) {
                showLine2 = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(5.0)) {
                showLine3 = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(6.5)) {
                showLine4 = true
            }
            
            withAnimation(.easeOut(duration: 1.5).delay(9.0)) {
                showTapToContinue = true
            }
        }
        .onTapGesture {
            HapticManager.shared.impact(style: .light)
            viewModel.nextStep()
        }
    }
    
    // MARK: - Computed Properties
    
    private var yearlyHours: String {
        guard let usage = viewModel.onboardingData.phoneUsageHours else { return "0" }
        let hours = usage.averageHours * 365
        return String(format: "%.0f", hours)
    }
    
    private var daysEquivalent: String {
        guard let usage = viewModel.onboardingData.phoneUsageHours else { return "0" }
        let hours = usage.averageHours * 365
        let days = hours / 24
        return String(format: "%.0f", days)
    }
    
    private var lifetimeYears: String {
        guard let usage = viewModel.onboardingData.phoneUsageHours else { return "0" }
        let dailyHours = usage.averageHours
        let yearlyDays = (dailyHours * 365) / 24
        let averageLifespanYears = 75.0
        let lifetimeDays = yearlyDays * averageLifespanYears
        let lifetimeYears = lifetimeDays / 365
        return String(format: "%.0f", lifetimeYears)
    }
}

#Preview {
    let viewModel = OnboardingViewModel()
    viewModel.onboardingData.name = "Taner"
    viewModel.onboardingData.phoneUsageHours = .fourToFive
    return OnboardingPhoneImpactView(viewModel: viewModel)
}
