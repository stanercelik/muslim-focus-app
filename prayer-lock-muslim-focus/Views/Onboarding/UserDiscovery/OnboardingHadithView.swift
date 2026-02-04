//
//  OnboardingHadithView.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

struct OnboardingHadithView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var showTitle = false
    @State private var showMessage1 = false
    @State private var showIntro = false
    @State private var showArabic = false
    @State private var showTranslation = false
    @State private var showSource = false
    @State private var showMessage2 = false
    @State private var showMessage3 = false
    @State private var showTapToContinue = false
    @State private var currentAnimationStep = 0
    @State private var buttonDelayTask: Task<Void, Never>?
    @State private var scrollProxy: ScrollViewProxy?
    
    var body: some View {
        ZStack {
            Color.appSurface
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Başlık
                Text("Dürüstlüğün için teşekkürler, \(viewModel.onboardingData.name)")
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
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
                    .frame(height: 32)
                
                ScrollView(showsIndicators: false) {
                    ScrollViewReader { proxy in
                        VStack(spacing: 72) {
                            // Mesaj 1
                            Text("Zorlanmak, bu dünya imtihanının bir parçasıdır. Yalnız değilsin.")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundColor(Color.appTextPrimary)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .opacity(showMessage1 ? 1.0 : 0.0)
                                .offset(y: showMessage1 ? 0 : 20)
                                .id("message1")
                                .onAppear {
                                    scrollProxy = proxy
                                }
                        
                            // Hadis bölümü
                            VStack(spacing: 32) {
                                // Intro
                                (Text("Peygamber Efendimiz ")
                                    .foregroundColor(Color.appTextPrimary.opacity(0.7)) +
                                Text("(sav)")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color.appTextPrimary.opacity(0.6))
                                    .fontWeight(.medium) +
                                Text(" şöyle buyurmuştur:")
                                    .foregroundColor(Color.appTextPrimary.opacity(0.7)))
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .opacity(showIntro ? 1.0 : 0.0)
                                .offset(y: showIntro ? 0 : 20)
                                .id("intro")
                                
                                // Arapça hadis
                                Text("كُلُّ بَنِي آدَمَ خَطَّاءٌ وَخَيْرُ الْخَطَّائِينَ التَّوَّابُونَ")
                                    .font(.system(size: 26, weight: .semibold, design: .serif))
                                    .foregroundColor(Color.appTextPrimary)
                                    .multilineTextAlignment(.center)
                                    .lineSpacing(12)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .opacity(showArabic ? 1.0 : 0.0)
                                    .offset(y: showArabic ? 0 : 20)
                                    .id("arabic")
                                
                                // Meal
                                (Text("\"Âdemoğullarının hepsi hata edicidir; hata edenlerin ")
                                    .foregroundColor(Color.appTextPrimary) +
                                Text("en hayırlısı")
                                    .foregroundColor(Color.appPrimary)
                                    .fontWeight(.bold) +
                                Text(" ise ")
                                    .foregroundColor(Color.appTextPrimary) +
                                Text("tövbe edenlerdir")
                                    .foregroundColor(Color.appPrimary)
                                    .fontWeight(.bold) +
                                Text(".\"")
                                    .foregroundColor(Color.appTextPrimary))
                                .font(.system(size: 17, weight: .medium, design: .rounded))
                                .multilineTextAlignment(.center)
                                .italic()
                                .lineSpacing(6)
                                .frame(maxWidth: .infinity)
                                .opacity(showTranslation ? 1.0 : 0.0)
                                .offset(y: showTranslation ? 0 : 20)
                                .id("translation")
                                
                                // Kaynak
                                Text("Tirmizî, Kıyâmet, 49; İbn Mâce, Zühd, 30")
                                    .font(.system(size: 13, weight: .medium, design: .rounded))
                                    .foregroundColor(Color.appTextPrimary.opacity(0.5))
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity)
                                    .opacity(showSource ? 1.0 : 0.0)
                                    .offset(y: showSource ? 0 : 20)
                                    .id("source")
                            }
                        
                            // Müjde mesajı
                            (Text("Müjde şu ki; ")
                                .foregroundColor(Color.appTextPrimary) +
                            Text("Allah'ın (cc) rahmeti")
                                .foregroundColor(Color.appPrimary)
                                .fontWeight(.bold) +
                            Text(" her şeyi kuşatmıştır. Senin bu ")
                                .foregroundColor(Color.appTextPrimary) +
                            Text("samimi niyetin")
                                .foregroundColor(Color.appPrimary)
                                .fontWeight(.bold) +
                            Text(", O'na giden yolda atılmış en güzel adımdır.")
                                .foregroundColor(Color.appTextPrimary))
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .opacity(showMessage2 ? 1.0 : 0.0)
                            .offset(y: showMessage2 ? 0 : 20)
                            .id("message2")
                            
                            // Son mesaj
                            (Text("Dua ve zikir")
                                .foregroundColor(Color.appPrimary)
                                .fontWeight(.bold) +
                            Text(", ")
                                .foregroundColor(Color.appTextPrimary) +
                            Text("kalbin ilacı")
                                .foregroundColor(Color.appPrimary)
                                .fontWeight(.bold) +
                            Text(" ve ")
                                .foregroundColor(Color.appTextPrimary) +
                            Text("günün bereketidir")
                                .foregroundColor(Color.appPrimary)
                                .fontWeight(.bold) +
                            Text(". Bu yolculukta her adımında seninleyiz.")
                                .foregroundColor(Color.appTextPrimary))
                            .font(.system(size: 18, weight: .medium, design: .rounded))
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .opacity(showMessage3 ? 1.0 : 0.0)
                            .offset(y: showMessage3 ? 0 : 20)
                            .id("message3")
                        }
                        .padding(.horizontal, 32)
                        .padding(.bottom, 100)
                        .onChange(of: showMessage1) { _, newValue in
                            if newValue {
                                withAnimation(.easeInOut(duration: 0.8)) {
                                    scrollProxy?.scrollTo("message1", anchor: .top)
                                }
                            }
                        }
                        .onChange(of: showIntro) { _, newValue in
                            if newValue {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.easeInOut(duration: 0.8)) {
                                        scrollProxy?.scrollTo("intro", anchor: .center)
                                    }
                                }
                            }
                        }
                        .onChange(of: showMessage2) { _, newValue in
                            if newValue {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    withAnimation(.easeInOut(duration: 0.8)) {
                                        scrollProxy?.scrollTo("message2", anchor: .center)
                                    }
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                    .frame(height: 24)
                
                // Tap to continue
                HStack {
                    Spacer()
                    Button(action: {
                        HapticManager.shared.impact(style: .medium)
                        viewModel.nextStep()
                    }) {
                        HStack(spacing: 6) {
                            Text("devam etmek için dokun")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 13, weight: .bold))
                        }
                        .foregroundColor(Color.appPrimary)
                    }
                    .opacity(showTapToContinue ? 1.0 : 0.0)
                    .padding(.trailing, 24)
                    .padding(.bottom, 50)
                }
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
        // Başlık
        withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
            showTitle = true
        }
        
        // Mesaj 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if currentAnimationStep == 0 {
                currentAnimationStep = 1
                withAnimation(.easeOut(duration: 1.2)) {
                    showMessage1 = true
                }
            }
        }
        
        // Hadis intro
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if currentAnimationStep == 1 {
                currentAnimationStep = 2
                withAnimation(.easeOut(duration: 1.2)) {
                    showIntro = true
                }
            }
        }
        
        // Arapça
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if currentAnimationStep == 2 {
                currentAnimationStep = 3
                withAnimation(.easeOut(duration: 1.2)) {
                    showArabic = true
                }
            }
        }
        
        // Meal
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            if currentAnimationStep == 3 {
                currentAnimationStep = 4
                withAnimation(.easeOut(duration: 1.2)) {
                    showTranslation = true
                }
            }
        }
        
        // Kaynak
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            if currentAnimationStep == 4 {
                currentAnimationStep = 5
                withAnimation(.easeOut(duration: 1.2)) {
                    showSource = true
                }
            }
        }
        
        // Mesaj 2
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.5) {
            if currentAnimationStep == 5 {
                currentAnimationStep = 6
                withAnimation(.easeOut(duration: 1.2)) {
                    showMessage2 = true
                }
            }
        }
        
        // Mesaj 3
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            if currentAnimationStep == 6 {
                currentAnimationStep = 7
                withAnimation(.easeOut(duration: 1.2)) {
                    showMessage3 = true
                }
            }
        }
        
        // Buton
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.5) {
            if currentAnimationStep == 7 {
                currentAnimationStep = 8
                startButtonDelay()
            }
        }
    }
    
    private func startButtonDelay() {
        buttonDelayTask?.cancel()
        buttonDelayTask = Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            await MainActor.run {
                withAnimation(.easeOut(duration: 1.5)) {
                    showTapToContinue = true
                }
            }
        }
    }
    
    private func handleTapToSkip() {
        // Tüm animasyonları hızlıca göster
        withAnimation(.easeOut(duration: 0.3)) {
            showTitle = true
            showMessage1 = true
            showIntro = true
            showArabic = true
            showTranslation = true
            showSource = true
            showMessage2 = true
            showMessage3 = true
        }
        
        if currentAnimationStep < 8 {
            currentAnimationStep = 8
            startButtonDelay()
        } else if showTapToContinue {
            HapticManager.shared.impact(style: .medium)
            viewModel.nextStep()
        }
    }
}

#Preview {
    OnboardingHadithView(viewModel: OnboardingViewModel())
}
