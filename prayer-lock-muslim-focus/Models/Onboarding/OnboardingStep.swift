//
//  OnboardingStep.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import Foundation

enum OnboardingStep: String, Codable, CaseIterable {
    case splash                     // E01
    case problemFraming            // E02
    case productPromise            // E03
    case nameInput                 // E04
    case transition                // E05 - "Tamam {name}..."
    case ageRange                  // E06
    case phoneUsage                // E06.5 - "günde ne kadar vakit"
    case phoneImpact               // E06.7 - hesaplama sonucu
    case timeIntro                 // E07 - "5 dakika"
    case goalSelection1            // E08
    case goalSelection2            // E09
    case thinkingBigger            // E10
    case youreInRightPlace         // E11
    case prayerFrequency           // E12
    case relationshipWithAllah     // E13
    case mainBlockers              // E14
    case deeperStruggles           // E15
    case thankYou1                 // E16
    case thankYou2                 // E17
    case thankYou3                 // E18
    case madhhabSelection          // E19
    case sexSelection              // E20
    case howItWorksModal           // E21
    case prayerIsPowerful          // E22
    case planSummary               // E23
    case moodCheckIn1              // E24
    case moodCheckIn2              // E25
    case moodCheckIn3              // E26
    case guidedPrayer              // E27
    case verseOfDay                // E28
    case congratulations           // E29
    case ratingPrompt              // E30
    case streakScreen              // E31
    case planBuilding              // E32 - Loading screens
    case planReady                 // E33
    case planDetails               // E34
    case commitment                // E35
    case encouragement             // E36
    case faithSnapshot             // E37
    case strengthsAreas            // E38
    case screenTimePermission      // E39
    case notificationPermission    // E40
    case socialProof               // E41
    case paywall                   // E42
    case completed                 // Final state
    
    var progressValue: Double {
        let index = Double(OnboardingStep.allCases.firstIndex(of: self) ?? 0)
        let total = Double(OnboardingStep.allCases.count)
        return index / total
    }
}
