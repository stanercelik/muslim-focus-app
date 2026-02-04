//
//  OnboardingTransitionView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingTransitionView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showLine1 = false
    @State private var showLine2 = false
    @State private var showTapToContinue = false
    
    var body: some View {
        ZStack {
            // Beyaz arka plan
            Color.white
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 12) {
                    Text("tamam \(viewModel.onboardingData.name),")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine1 ? 1.0 : 0.0)
                        .offset(y: showLine1 ? 0 : 20)
                    
                    Text("bunu bir düşün...")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine2 ? 1.0 : 0.0)
                        .offset(y: showLine2 ? 0 : 20)
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Tap to continue
                HStack {
                    Spacer()
                    Button(action: {
                        HapticManager.shared.impact(style: .medium)
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
            
            withAnimation(.easeOut(duration: 1.0).delay(1.5)) {
                showLine2 = true
            }
            
            withAnimation(.easeOut(duration: 1.5).delay(2.5)) {
                showTapToContinue = true
            }
        }
        .onTapGesture {
            HapticManager.shared.impact(style: .medium)
            viewModel.nextStep()
        }
    }
}

#Preview {
    let viewModel = OnboardingViewModel()
    viewModel.onboardingData.name = "Ali"
    return OnboardingTransitionView(viewModel: viewModel)
}
