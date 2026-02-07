//
//  LocalizationKeys.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import Foundation
import SwiftUI

/// Tüm localization key'lerini type-safe bir şekilde kullanmak için extension
/// String Catalog'da tanımlı tüm key'lere bu extension üzerinden erişebilirsin
extension LocalizedStringKey {
    // MARK: - Onboarding
    static let greeting = LocalizedStringKey("greeting")
    static let journeyBismillah = LocalizedStringKey("journey_bismillah")
    static let tapToContinue = LocalizedStringKey("tap_to_continue")
    static let continueButton = LocalizedStringKey("continue_button")
    static let devBadge = LocalizedStringKey("dev_badge")
    static let devModeOnboardingCompleted = LocalizedStringKey("dev_mode_onboarding_completed")
    static let onboardingCompletedTitle = LocalizedStringKey("onboarding_completed_title")
    static let onboardingCompletedMessage = LocalizedStringKey("onboarding_completed_message")

    // MARK: - Right Place
    static let youreInRightPlaceCard1Title = LocalizedStringKey("youre_in_right_place_card1_title")
    static let youreInRightPlaceCard1Body = LocalizedStringKey("youre_in_right_place_card1_body")
    static let youreInRightPlaceCard2Title = LocalizedStringKey("youre_in_right_place_card2_title")
    static let youreInRightPlaceCard2Body = LocalizedStringKey("youre_in_right_place_card2_body")
    static let youreInRightPlaceCard3Title = LocalizedStringKey("youre_in_right_place_card3_title")
    static let youreInRightPlaceCard3Body = LocalizedStringKey("youre_in_right_place_card3_body")
    static let youreInRightPlaceSummaryLabel = LocalizedStringKey("youre_in_right_place_summary_label")
    static let youreInRightPlaceSummaryTitle = LocalizedStringKey("youre_in_right_place_summary_title")
    static let youreInRightPlaceSummaryStat = LocalizedStringKey("youre_in_right_place_summary_stat")
    static let youreInRightPlaceFooterTitle = LocalizedStringKey("youre_in_right_place_footer_title")
    static let youreInRightPlaceFooterBody = LocalizedStringKey("youre_in_right_place_footer_body")
    
    // MARK: - Content
    static let contentAddItem = LocalizedStringKey("content_add_item")
    static let contentSelectItem = LocalizedStringKey("content_select_item")
    
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
    static let phoneImpactHeadline = LocalizedStringKey("phone_impact_headline")
    static let phoneImpactCardTitle = LocalizedStringKey("phone_impact_card_title")
    static let phoneImpactDescription = LocalizedStringKey("phone_impact_description")
    static let phoneImpactHowItWorks = LocalizedStringKey("phone_impact_how_it_works")
    static let phoneImpactSkippedPrayer = LocalizedStringKey("phone_impact_skipped_prayer")
    static let phoneImpactPrayLater = LocalizedStringKey("phone_impact_pray_later")
    static let phoneImpactDevilWon = LocalizedStringKey("phone_impact_devil_won")
    static let phoneImpactWeek1 = LocalizedStringKey("phone_impact_week_1")
    static let phoneImpactWeek2 = LocalizedStringKey("phone_impact_week_2")
    static let phoneImpactWeek3 = LocalizedStringKey("phone_impact_week_3")
    static let prayerIsPowerfulDialogTitle = LocalizedStringKey("prayer_is_powerful_dialog_title")
    static let prayerIsPowerfulDialogStep1 = LocalizedStringKey("prayer_is_powerful_dialog_step_1")
    static let prayerIsPowerfulDialogStep2 = LocalizedStringKey("prayer_is_powerful_dialog_step_2")
    static let prayerIsPowerfulDialogStep3 = LocalizedStringKey("prayer_is_powerful_dialog_step_3")
    static let prayerIsPowerfulDialogFooter = LocalizedStringKey("prayer_is_powerful_dialog_footer")
    static let prayerIsPowerfulDialogButton = LocalizedStringKey("prayer_is_powerful_dialog_button")
    static let onboardingSummaryTitle = LocalizedStringKey("onboarding_summary_title")
    static let onboardingSummarySubtitle = LocalizedStringKey("onboarding_summary_subtitle")
    static let onboardingSummaryGoalLabel = LocalizedStringKey("onboarding_summary_goal_label")
    static let onboardingSummaryStateLabel = LocalizedStringKey("onboarding_summary_state_label")
    static let onboardingSummaryBlockersLabel = LocalizedStringKey("onboarding_summary_blockers_label")
    static let onboardingSummaryFooter = LocalizedStringKey("onboarding_summary_footer")
    static let onboardingSummaryContinue = LocalizedStringKey("onboarding_summary_continue")
    static let onboardingSummaryDefaultName = LocalizedStringKey("onboarding_summary_default_name")
    static let onboardingSummaryGoalEmpty = LocalizedStringKey("onboarding_summary_goal_empty")
    static let onboardingSummaryStateEmpty = LocalizedStringKey("onboarding_summary_state_empty")
    static let onboardingSummaryBlockersEmpty = LocalizedStringKey("onboarding_summary_blockers_empty")
    
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

    // MARK: - User Discovery
    static let userDiscoveryMadhhabTitle = LocalizedStringKey("user_discovery_madhhab_title")
    static let userDiscoveryBlockersTitle = LocalizedStringKey("user_discovery_blockers_title")
    static let userDiscoveryBiggerVisionTitle = LocalizedStringKey("user_discovery_bigger_vision_title")
    static let userDiscoverySexTitle = LocalizedStringKey("user_discovery_sex_title")
    static let userDiscoveryPrayerFrequencyTitle = LocalizedStringKey("user_discovery_prayer_frequency_title")
    static let userDiscoveryPrayerFrequencyDaySingular = LocalizedStringKey("user_discovery_prayer_frequency_day_singular")
    static let userDiscoveryPrayerFrequencyDayPlural = LocalizedStringKey("user_discovery_prayer_frequency_day_plural")
    static let userDiscoveryGoalTitle = LocalizedStringKey("user_discovery_goal_title")
    static let userDiscoveryGoalSubtitle = LocalizedStringKey("user_discovery_goal_subtitle")
    static let userDiscoveryRootStrugglesTitle = LocalizedStringKey("user_discovery_root_struggles_title")
    static let userDiscoveryRootStrugglesSubtitle = LocalizedStringKey("user_discovery_root_struggles_subtitle")

    static let userDiscoveryRelationshipPrefix = LocalizedStringKey("user_discovery_relationship_prefix")
    static let userDiscoveryRelationshipAllah = LocalizedStringKey("user_discovery_relationship_allah")
    static let userDiscoveryRelationshipCc = LocalizedStringKey("user_discovery_relationship_cc")
    static let userDiscoveryRelationshipSuffix = LocalizedStringKey("user_discovery_relationship_suffix")

    static let userDiscoveryHadithMessage1 = LocalizedStringKey("user_discovery_hadith_message1")
    static let userDiscoveryHadithIntroPrefix = LocalizedStringKey("user_discovery_hadith_intro_prefix")
    static let userDiscoveryHadithIntroSav = LocalizedStringKey("user_discovery_hadith_intro_sav")
    static let userDiscoveryHadithIntroSuffix = LocalizedStringKey("user_discovery_hadith_intro_suffix")
    static let userDiscoveryHadithArabic = LocalizedStringKey("user_discovery_hadith_arabic")
    static let userDiscoveryHadithTranslationPrefix = LocalizedStringKey("user_discovery_hadith_translation_prefix")
    static let userDiscoveryHadithTranslationHighlight1 = LocalizedStringKey("user_discovery_hadith_translation_highlight1")
    static let userDiscoveryHadithTranslationMid = LocalizedStringKey("user_discovery_hadith_translation_mid")
    static let userDiscoveryHadithTranslationHighlight2 = LocalizedStringKey("user_discovery_hadith_translation_highlight2")
    static let userDiscoveryHadithTranslationSuffix = LocalizedStringKey("user_discovery_hadith_translation_suffix")
    static let userDiscoveryHadithSource = LocalizedStringKey("user_discovery_hadith_source")
    static let userDiscoveryHadithMessage2Prefix = LocalizedStringKey("user_discovery_hadith_message2_prefix")
    static let userDiscoveryHadithMessage2Highlight1 = LocalizedStringKey("user_discovery_hadith_message2_highlight1")
    static let userDiscoveryHadithMessage2Mid = LocalizedStringKey("user_discovery_hadith_message2_mid")
    static let userDiscoveryHadithMessage2Highlight2 = LocalizedStringKey("user_discovery_hadith_message2_highlight2")
    static let userDiscoveryHadithMessage2Suffix = LocalizedStringKey("user_discovery_hadith_message2_suffix")
    static let userDiscoveryHadithMessage3Highlight1 = LocalizedStringKey("user_discovery_hadith_message3_highlight1")
    static let userDiscoveryHadithMessage3Separator1 = LocalizedStringKey("user_discovery_hadith_message3_separator1")
    static let userDiscoveryHadithMessage3Highlight2 = LocalizedStringKey("user_discovery_hadith_message3_highlight2")
    static let userDiscoveryHadithMessage3Separator2 = LocalizedStringKey("user_discovery_hadith_message3_separator2")
    static let userDiscoveryHadithMessage3Highlight3 = LocalizedStringKey("user_discovery_hadith_message3_highlight3")
    static let userDiscoveryHadithMessage3Suffix = LocalizedStringKey("user_discovery_hadith_message3_suffix")
}

enum UserDiscoveryStrings {
    static func hadithTitle(name: String) -> String {
        L10n.text("user_discovery_hadith_title", name)
    }
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

extension DifficultyMode {
    var localizedKey: String {
        switch self {
        case .easy: return "difficulty_easy"
        case .medium: return "difficulty_medium"
        case .hard: return "difficulty_hard"
        }
    }

    var localizedDisplayText: String {
        NSLocalizedString(localizedKey, comment: "")
    }
}
