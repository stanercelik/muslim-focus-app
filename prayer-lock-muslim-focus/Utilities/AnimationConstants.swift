//
//  AnimationConstants.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import Foundation

/// Tüm onboarding ekranlarında kullanılan standart animasyon timing değerleri
/// Minimum 1-1.5sn delay'ler ile yavaş ve rahat bir deneyim
enum AnimationConstants {
    // MARK: - Duration
    /// Normal fade in/out animasyonları için standart süre
    static let standardDuration: Double = 1.0
    
    /// "Tap to continue" butonu için yavaş fade in süresi
    static let tapToContinueDuration: Double = 1.5
    
    // MARK: - Delays (Minimum 1.5sn gap)
    /// İlk element için başlangıç delay'i
    static let firstElementDelay: Double = 0.5
    
    /// İkinci element için delay (başlık içinde)
    static let secondElementDelay: Double = 2.0
    
    /// Üçüncü element için delay (başlık içinde)
    static let thirdElementDelay: Double = 3.5
    
    /// Dördüncü element için delay (başlık içinde - eğer varsa)
    static let fourthElementDelay: Double = 5.0
    
    /// İkinci grup başlangıcı için delay (büyük gap sonrası)
    static let secondGroupStartDelay: Double = 6.5
    
    /// İkinci grup element'leri arasındaki gap
    static let secondGroupGap: Double = 1.5
    
    /// "Tap to continue" için final delay
    static let tapToContinueDelay: Double = 13.0
    
    // MARK: - Helper Functions
    /// İkinci gruptaki n'inci element için delay hesapla
    /// - Parameter index: Element index'i (0'dan başlar)
    /// - Returns: Delay değeri
    static func secondGroupDelay(at index: Int) -> Double {
        return secondGroupStartDelay + (Double(index) * secondGroupGap)
    }
}

// MARK: - Usage Examples
/*
 // Standart 3 satırlık başlık:
 withAnimation(.easeOut(duration: AnimationConstants.standardDuration)
               .delay(AnimationConstants.firstElementDelay)) {
     showTitle1 = true
 }
 
 withAnimation(.easeOut(duration: AnimationConstants.standardDuration)
               .delay(AnimationConstants.secondElementDelay)) {
     showTitle2 = true
 }
 
 withAnimation(.easeOut(duration: AnimationConstants.standardDuration)
               .delay(AnimationConstants.thirdElementDelay)) {
     showTitle3 = true
 }
 
 // İkinci grup element'ler (3.2, 4.2, 5.2):
 withAnimation(.easeOut(duration: AnimationConstants.standardDuration)
               .delay(AnimationConstants.secondGroupDelay(at: 0))) {
     showFeature1 = true
 }
 
 withAnimation(.easeOut(duration: AnimationConstants.standardDuration)
               .delay(AnimationConstants.secondGroupDelay(at: 1))) {
     showFeature2 = true
 }
 
 // Tap to continue (en son):
 withAnimation(.easeOut(duration: AnimationConstants.tapToContinueDuration)
               .delay(AnimationConstants.tapToContinueDelay)) {
     showTapToContinue = true
 }
 */
