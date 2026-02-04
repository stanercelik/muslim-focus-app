//
//  LocalizationKeys.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

/// Tüm localization key'lerini type-safe bir şekilde kullanmak için extension
/// String Catalog'da tanımlı tüm key'lere bu extension üzerinden erişebilirsin
extension LocalizedStringKey {
    // MARK: - Onboarding
    static let greeting = LocalizedStringKey("greeting")
    static let journeyBismillah = LocalizedStringKey("journey_bismillah")
    static let tapToContinue = LocalizedStringKey("tap_to_continue")
    static let continueButton = LocalizedStringKey("continue_button")
    
    // MARK: - Name Input
    static let getToKnowYou = LocalizedStringKey("get_to_know_you")
    static let nameQuestion = LocalizedStringKey("name_question")
    static let nameInputPlaceholder = LocalizedStringKey("name_input_placeholder")
    
    // MARK: - Age Range
    static let ageQuestion = LocalizedStringKey("age_question")
    
    // MARK: - Phone Usage
    static let phoneUsageQuestion = LocalizedStringKey("phone_usage_question")
    static let timeIsPrecious = LocalizedStringKey("time_is_precious")
    
    // MARK: - Problem Framing
    static let problemFramingTitle = LocalizedStringKey("problem_framing_title")
    static let problemFramingLine1 = LocalizedStringKey("problem_framing_line1")
    static let problemFramingLine2 = LocalizedStringKey("problem_framing_line2")
    static let problemFramingLine3 = LocalizedStringKey("problem_framing_line3")
    static let problemFramingLine4 = LocalizedStringKey("problem_framing_line4")
    
    // MARK: - Phone Impact
    static let phoneImpactYearlyHours = LocalizedStringKey("phone_impact_yearly_hours")
    static let phoneImpactDaysEquivalent = LocalizedStringKey("phone_impact_days_equivalent")
    static let phoneImpactLifetime = LocalizedStringKey("phone_impact_lifetime")
    static let phoneImpactQuestion = LocalizedStringKey("phone_impact_question")
    
    // MARK: - Product Promise
    static let productPromiseTitle = LocalizedStringKey("product_promise_title")
    static let productPromiseFeature1 = LocalizedStringKey("product_promise_feature1")
    static let productPromiseFeature2 = LocalizedStringKey("product_promise_feature2")
    static let productPromiseFeature3 = LocalizedStringKey("product_promise_feature3")
    
    // MARK: - Time Intro
    static let phoneBlessingIntro = LocalizedStringKey("phone_blessing_intro")
    static let timeCommitmentQuestion = LocalizedStringKey("time_commitment_question")
    static let spiritualPlanIntro = LocalizedStringKey("spiritual_plan_intro")
    
    // MARK: - Transition
    static let transitionGreeting = LocalizedStringKey("transition_greeting")
    static let transitionMessage = LocalizedStringKey("transition_message")
}

/// Enum displayText'leri için localization key'leri
extension AgeRange {
    var localizedKey: String {
        switch self {
        case .range14_24: return "age_range_14_24"
        case .range25_34: return "age_range_25_34"
        case .range35_44: return "age_range_35_44"
        case .range45_54: return "age_range_45_54"
        case .range55Plus: return "age_range_55_plus"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension PhoneUsageRange {
    var localizedKey: String {
        switch self {
        case .oneToTwo: return "phone_usage_range_1_2"
        case .twoToThree: return "phone_usage_range_2_3"
        case .threeToFour: return "phone_usage_range_3_4"
        case .fourToFive: return "phone_usage_range_4_5"
        case .fiveToSix: return "phone_usage_range_5_6"
        case .sixPlus: return "phone_usage_range_6_plus"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension UserGoal {
    var localizedKey: String {
        switch self {
        case .putGodFirst: return "goal_put_god_first"
        case .buildPrayerHabit: return "goal_build_prayer_habit"
        case .deepenRelationship: return "goal_deepen_relationship"
        case .findPeace: return "goal_find_peace"
        case .startWithIntention: return "goal_start_with_intention"
        case .centerQuran: return "goal_center_quran"
        case .liveSunnah: return "goal_live_sunnah"
        case .avoidWaste: return "goal_avoid_waste"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension BiggerVision {
    var localizedKey: String {
        switch self {
        case .tevekkul: return "vision_tevekkul"
        case .istikamet: return "vision_istikamet"
        case .infak: return "vision_infak"
        case .nefsMucadelesi: return "vision_nefs_mucadelesi"
        case .prophetCharacter: return "vision_prophet_character"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension SpiritualState {
    var localizedKey: String {
        switch self {
        case .fluctuating: return "spiritual_state_fluctuating"
        case .distant: return "spiritual_state_distant"
        case .newStart: return "spiritual_state_new_start"
        case .close: return "spiritual_state_close"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension Blocker {
    var localizedKey: String {
        switch self {
        case .phoneDistraction: return "blocker_phone_distraction"
        case .lossOfKhushu: return "blocker_loss_of_khushu"
        case .spiritualEmptiness: return "blocker_spiritual_emptiness"
        case .worldlyBusyness: return "blocker_worldly_busyness"
        case .fajrDifficulty: return "blocker_fajr_difficulty"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension RootStruggle {
    var localizedKey: String {
        switch self {
        case .nafsaniDesires: return "struggle_nafsani_desires"
        case .futureAnxiety: return "struggle_future_anxiety"
        case .heartHardness: return "struggle_heart_hardness"
        case .arrogance: return "struggle_arrogance"
        case .pastGuilt: return "struggle_past_guilt"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension Madhhab {
    var localizedKey: String {
        switch self {
        case .hanafi: return "madhhab_hanafi"
        case .shafii: return "madhhab_shafii"
        case .malikiHanbali: return "madhhab_maliki_hanbali"
        case .general: return "madhhab_general"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension Sex {
    var localizedKey: String {
        switch self {
        case .male: return "sex_male"
        case .female: return "sex_female"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension Mood {
    var localizedKey: String {
        switch self {
        case .good: return "mood_good"
        case .great: return "mood_great"
        case .bad: return "mood_bad"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}

extension CommitmentLevel {
    var localizedKey: String {
        switch self {
        case .veryCommitted: return "commitment_very"
        case .committed: return "commitment_committed"
        case .somewhatCommitted: return "commitment_somewhat"
        case .lessCommitted: return "commitment_less"
        case .justTrying: return "commitment_trying"
        }
    }
    
    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}
