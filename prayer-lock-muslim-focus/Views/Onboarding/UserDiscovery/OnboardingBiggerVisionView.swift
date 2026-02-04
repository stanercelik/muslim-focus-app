//
//  OnboardingBiggerVisionView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingBiggerVisionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showTitle = false
    @State private var showSubtitle = false
    @State private var showOptions = false
    @State private var showButton = false
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Başlık
                Text("Daha geniş düşünürsek, 'kamil bir iman' senin için ne ifade ediyor?")
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
                    .frame(height: 24)
                
                // Seçenekler
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(BiggerVision.allCases, id: \.self) { vision in
                            VisionOptionButton(
                                title: vision.displayText,
                                isSelected: viewModel.onboardingData.biggerVision == vision,
                                action: {
                                    HapticManager.shared.impact(style: .medium)
                                    viewModel.selectBiggerVision(vision)
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 32)
                }
                .opacity(showOptions ? 1.0 : 0.0)
                .offset(y: showOptions ? 0 : 20)
                
                // Continue button
                GradientButton(
                    title: "Devam Et",
                    isEnabled: viewModel.onboardingData.biggerVision != nil,
                    action: {
                        HapticManager.shared.impact(style: .medium)
                        viewModel.nextStep()
                    }
                )
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 50)
                .opacity(showButton ? 1.0 : 0.0)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                showTitle = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(2.0)) {
                showOptions = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(3.5)) {
                showButton = true
            }
        }
    }
}

// MARK: - Vision Option Button
struct VisionOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .top, spacing: 16) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.appTextPrimary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.appPrimary)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.appSurface)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isSelected ? Color.appPrimary : Color.clear, lineWidth: 2)
                    )
            )
        }
    }
}

#Preview {
    OnboardingBiggerVisionView(viewModel: OnboardingViewModel())
}
