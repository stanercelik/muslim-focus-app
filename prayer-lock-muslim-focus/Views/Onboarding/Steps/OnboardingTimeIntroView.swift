//
//  OnboardingTimeIntroView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingTimeIntroView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showLine1 = false
    @State private var showLine2 = false
    @State private var showLine4 = false
    @State private var showTapToContinue = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Metin
                VStack(alignment: .leading, spacing: 20) {
                    Text("böyle olmak zorunda değil.")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .opacity(showLine1 ? 1.0 : 0.0)
                        .offset(y: showLine1 ? 0 : 20)
                    
                    Text("her gün Allah için sadece \(Text("5 dakika").foregroundColor(Color("AccentColor")).fontWeight(.heavy)) ayırabilir misin?")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine2 ? 1.0 : 0.0)
                        .offset(y: showLine2 ? 0 : 20)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text("senin için bir plan yapalım.")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
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
            
            withAnimation(.easeOut(duration: 1.0).delay(1.5)) {
                showLine2 = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(4.0)) {
                showLine4 = true
            }
            
            withAnimation(.easeOut(duration: 1.5).delay(6.5)) {
                showTapToContinue = true
            }
        }
        .onTapGesture {
            HapticManager.shared.impact(style: .light)
            viewModel.nextStep()
        }
    }
}

#Preview {
    OnboardingTimeIntroView(viewModel: OnboardingViewModel())
}
