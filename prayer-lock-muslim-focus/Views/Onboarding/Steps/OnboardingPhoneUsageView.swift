//
//  OnboardingPhoneUsageView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingPhoneUsageView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showTitle = false
    @State private var showSubtext = false
    @State private var showOptions = false
    @State private var showButton = false
    @State private var currentAnimationStep = 0
    @State private var buttonDelayTask: Task<Void, Never>?
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Başlık
                Text(.phoneUsageQuestion)
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.appTextPrimary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .padding(.top, 64)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .minimumScaleFactor(0.7)
                    .allowsTightening(true)
                    .opacity(showTitle ? 1.0 : 0.0)
                    .offset(y: showTitle ? 0 : 20)
                
                Spacer()
                    .frame(height: 16)
                
                // Alt metin
                Text(.timeIsPrecious)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.appTextPrimary.opacity(0.6))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .opacity(showSubtext ? 1.0 : 0.0)
                    .offset(y: showSubtext ? 0 : 20)
                
                Spacer()
                    .frame(height: 40)
                
                // Seçenekler
                VStack(spacing: 16) {
                    ForEach(PhoneUsageRange.allCases, id: \.self) { range in
                        PhoneUsageOptionButton(
                            title: range.localizedDisplayText,
                            isSelected: viewModel.onboardingData.phoneUsageHours == range,
                            action: {
                                HapticManager.shared.impact(style: .medium)
                                viewModel.selectPhoneUsage(range)
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
                    title: .continueButton,
                    isEnabled: viewModel.onboardingData.phoneUsageHours != nil,
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
        .onTapGesture {
            handleTapToSkip()
        }
        .onAppear {
            startAnimationSequence()
        }
    }
    
    private func startAnimationSequence() {
        // Başlık animasyonu
        withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
            showTitle = true
        }
        
        // 1.5 saniye sonra otomatik olarak subtext'e geç
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if currentAnimationStep == 0 {
                currentAnimationStep = 1
                withAnimation(.easeOut(duration: 1.0)) {
                    showSubtext = true
                }
            }
        }
        
        // 2.5 saniye sonra otomatik olarak options'a geç
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if currentAnimationStep == 1 {
                currentAnimationStep = 2
                withAnimation(.easeOut(duration: 1.0)) {
                    showOptions = true
                }
            }
        }
        
        // 3.5 saniye sonra buton için delay başlat (bu ilerletilemez)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            if currentAnimationStep == 2 {
                currentAnimationStep = 3
                startButtonDelay()
            }
        }
    }
    
    private func startButtonDelay() {
        buttonDelayTask?.cancel()
        buttonDelayTask = Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000) // 1 saniye bekle
            await MainActor.run {
                withAnimation(.easeOut(duration: 1.0)) {
                    showButton = true
                }
            }
        }
    }
    
    private func handleTapToSkip() {
        switch currentAnimationStep {
        case 0:
            // Başlığı direkt göster
            withAnimation(.easeOut(duration: 0.3)) {
                showTitle = true
            }
            currentAnimationStep = 1
            // Subtext animasyonunu başlat
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showSubtext = true
                }
            }
            
        case 1:
            // Subtext'i direkt göster
            withAnimation(.easeOut(duration: 0.3)) {
                showSubtext = true
            }
            currentAnimationStep = 2
            // Options animasyonunu başlat
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.easeOut(duration: 1.0)) {
                    showOptions = true
                }
            }
            
        case 2:
            // Options'ı direkt göster
            withAnimation(.easeOut(duration: 0.3)) {
                showOptions = true
            }
            currentAnimationStep = 3
            // Buton delay'ini başlat (bu ilerletilemez)
            startButtonDelay()
            
        default:
            // Buton görünürken tap yapılırsa hiçbir şey yapma
            break
        }
    }
}

// MARK: - Phone Usage Option Button
struct PhoneUsageOptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.appTextPrimary)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.appPrimary)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
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
    OnboardingPhoneUsageView(viewModel: OnboardingViewModel())
}
