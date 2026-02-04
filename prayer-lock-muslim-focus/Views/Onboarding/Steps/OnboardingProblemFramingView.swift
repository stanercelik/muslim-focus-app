//
//  OnboardingProblemFramingView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingProblemFramingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showMainTitle = false
    @State private var showLine1 = false
    @State private var showLine2 = false
    @State private var showLine3 = false
    @State private var showLine4 = false
    @State private var showTapToContinue = false
    
    var body: some View {
        ZStack {
            // Beyaz arka plan
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Ana soru - tek Text ile çok satırlı
                Text("hiç telefonun \(Text("Allah'tan").foregroundColor(Color("AccentColor")).fontWeight(.bold)) daha çok ilgi istediğini hissediyor musun?")
                    .font(.system(size: 32, weight: .semibold, design: .rounded))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)
                    .opacity(showMainTitle ? 1.0 : 0.0)
                    .offset(y: showMainTitle ? 0 : 20)
                
                Spacer()
                    .frame(height: 40)
                
                // Alt metin - her satır ayrı fade in
                VStack(alignment: .leading, spacing: 12) {
                    Text("yalnız değilsin.")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine1 ? 1.0 : 0.0)
                        .offset(y: showLine1 ? 0 : 20)
                    
                    Text("dikkat dağıtıcılar her yerde,")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine2 ? 1.0 : 0.0)
                        .offset(y: showLine2 ? 0 : 20)
                    
                    Text("seni huzurdan yavaşça")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .foregroundColor(.black)
                        .opacity(showLine3 ? 1.0 : 0.0)
                        .offset(y: showLine3 ? 0 : 20)
                    
                    Text("uzaklaştırabiliyor.")
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
            // Ana başlık
            withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
                showMainTitle = true
            }
            
            // Alt metin satırları
            withAnimation(.easeOut(duration: 1.0).delay(3.5)) {
                showLine1 = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(5.0)) {
                showLine2 = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(6.5)) {
                showLine3 = true
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(8.0)) {
                showLine4 = true
            }
            
            // Tap to continue en son
            withAnimation(.easeOut(duration: 1.5).delay(10.0)) {
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
    OnboardingProblemFramingView(viewModel: OnboardingViewModel())
}
