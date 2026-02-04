//
//  OnboardingRelationshipView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingRelationshipView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showTitle = false
    @State private var showOptions = false
    @State private var showButton = false
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Başlık
                VStack(alignment: .leading, spacing: 4) {
                    (Text("Şu an ")
                        .foregroundColor(Color.appTextPrimary) +
                    Text("Allah ")
                        .foregroundColor(Color.appPrimary)
                        .fontWeight(.bold) +
                    Text("(cc)")
                        .font(.system(size: 26))
                        .foregroundColor(Color.appTextPrimary.opacity(0.6))
                        .fontWeight(.medium) +
                    Text(" ile olan bağını nasıl tarif edersin?")
                        .foregroundColor(Color.appTextPrimary))
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                    .minimumScaleFactor(0.7)
                }
                .padding(.horizontal, 32)
                .padding(.top, 64)
                .opacity(showTitle ? 1.0 : 0.0)
                .offset(y: showTitle ? 0 : 20)
                
                Spacer()
                    .frame(height: 24)
                
                // Seçenekler
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(SpiritualState.allCases, id: \.self) { state in
                            SpiritualStateOptionButton(
                                title: state.displayText,
                                isSelected: viewModel.onboardingData.spiritualState == state,
                                action: {
                                    HapticManager.shared.impact(style: .medium)
                                    viewModel.selectSpiritualState(state)
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
                    isEnabled: viewModel.onboardingData.spiritualState != nil,
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

// MARK: - Spiritual State Option Button
struct SpiritualStateOptionButton: View {
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
    OnboardingRelationshipView(viewModel: OnboardingViewModel())
}
