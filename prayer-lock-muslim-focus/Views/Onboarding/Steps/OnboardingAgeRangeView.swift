//
//  OnboardingAgeRangeView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingAgeRangeView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showTitle = false
    @State private var showOptions = false
    @State private var showButton = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Başlık
                Text("kaç yaşındasın?")
                    .font(.system(size: 32, weight: .medium, design: .rounded))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .padding(.top, 80)
                    .opacity(showTitle ? 1.0 : 0.0)
                    .offset(y: showTitle ? 0 : 20)
                
                Spacer()
                    .frame(height: 50)
                
                // Seçenekler
                VStack(spacing: 16) {
                    ForEach(AgeRange.allCases, id: \.self) { range in
                        AgeRangeOptionButton(
                            title: range.displayText,
                            isSelected: viewModel.onboardingData.ageRange == range,
                            action: {
                                HapticManager.shared.impact(style: .medium)
                                viewModel.selectAgeRange(range)
                            }
                        )
                    }
                }
                .padding(.horizontal, 32)
                .opacity(showOptions ? 1.0 : 0.0)
                .offset(y: showOptions ? 0 : 20)
                
                Spacer()
                    .frame(minHeight: 40)
                
                // Continue button
                GradientButton(
                    title: "continue",
                    isEnabled: viewModel.onboardingData.ageRange != nil,
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
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                showTitle = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(1.5)) {
                showOptions = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(3.0)) {
                showButton = true
            }
        }
    }
}

// MARK: - Age Range Option Button
struct AgeRangeOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .medium, design: .rounded))
                    .foregroundColor(.black)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color("AccentColor"))
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? Color("AccentColor") : Color.clear, lineWidth: 2)
                    )
            )
        }
    }
}

#Preview {
    OnboardingAgeRangeView(viewModel: OnboardingViewModel())
}
