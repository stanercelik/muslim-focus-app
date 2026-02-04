//
//  OnboardingProductPromiseView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingProductPromiseView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showTitle1 = false
    @State private var showFeature1 = false
    @State private var showFeature2 = false
    @State private var showFeature3 = false
    @State private var showTapToContinue = false
    
    var body: some View {
        ZStack {
            // Beyaz arka plan
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Ana başlık - tek Text ile çok satırlı
                Text("muslim focus sana \(Text("Allah'ı önce").foregroundColor(Color("AccentColor")).fontWeight(.bold)) koymanda yardım eder")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .opacity(showTitle1 ? 1.0 : 0.0)
                    .offset(y: showTitle1 ? 0 : 20)
                
                Spacer()
                    .frame(height: 50)
                
                // Özellikler - her biri ayrı fade in
                VStack(alignment: .leading, spacing: 20) {
                    Text("bu \(Text("çok basit").foregroundColor(Color("AccentColor")).fontWeight(.bold))")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showFeature1 ? 1.0 : 0.0)
                        .offset(y: showFeature1 ? 0 : 20)
                    
                    Text("her gün")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showFeature2 ? 1.0 : 0.0)
                        .offset(y: showFeature2 ? 0 : 20)
                    
                    Text("\(Text("ibadet ederek").foregroundColor(Color("AccentColor")).fontWeight(.bold)) uygulamalarını açarsın")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showFeature3 ? 1.0 : 0.0)
                        .offset(y: showFeature3 ? 0 : 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 32)
                
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
            // Ana başlık
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                showTitle1 = true
            }
            
            // Özellikler
            withAnimation(.easeOut(duration: 1.0).delay(3.5)) {
                showFeature1 = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(5.0)) {
                showFeature2 = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(6.5)) {
                showFeature3 = true
            }
            
            // Tap to continue en son
            withAnimation(.easeOut(duration: 1.5).delay(8.0)) {
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
    OnboardingProductPromiseView(viewModel: OnboardingViewModel())
}
