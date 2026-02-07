//
//  OnboardingData.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import Foundation

struct OnboardingData: Codable, Equatable {
    var name: String = ""
    var ageRange: AgeRange?
    var phoneUsageHours: PhoneUsageRange?
    var selectedGoals: [UserGoal] = []
    var biggerVision: BiggerVision?
    var ibadahDaysPerWeek: Int = 0
    var spiritualState: SpiritualState?
    var blockers: [Blocker] = []
    var rootStruggles: [RootStruggle] = []
    var madhhab: Madhhab?
    var sex: Sex?
    var mood: Mood?
    var preferredDifficulty: DifficultyMode = .medium
    var commitment: CommitmentLevel?
    var hasCompletedOnboarding: Bool = false

    enum CodingKeys: String, CodingKey {
        case name
        case ageRange
        case phoneUsageHours
        case selectedGoals
        case biggerVision
        case ibadahDaysPerWeek
        case spiritualState
        case blockers
        case rootStruggles
        case madhhab
        case sex
        case mood
        case preferredDifficulty
        case commitment
        case hasCompletedOnboarding
    }

    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        ageRange = try container.decodeIfPresent(AgeRange.self, forKey: .ageRange)
        phoneUsageHours = try container.decodeIfPresent(PhoneUsageRange.self, forKey: .phoneUsageHours)
        selectedGoals = try container.decodeIfPresent([UserGoal].self, forKey: .selectedGoals) ?? []
        biggerVision = try container.decodeIfPresent(BiggerVision.self, forKey: .biggerVision)
        ibadahDaysPerWeek = try container.decodeIfPresent(Int.self, forKey: .ibadahDaysPerWeek) ?? 0
        spiritualState = try container.decodeIfPresent(SpiritualState.self, forKey: .spiritualState)
        blockers = try container.decodeIfPresent([Blocker].self, forKey: .blockers) ?? []
        rootStruggles = try container.decodeIfPresent([RootStruggle].self, forKey: .rootStruggles) ?? []
        madhhab = try container.decodeIfPresent(Madhhab.self, forKey: .madhhab)
        sex = try container.decodeIfPresent(Sex.self, forKey: .sex)
        mood = try container.decodeIfPresent(Mood.self, forKey: .mood)
        preferredDifficulty = try container.decodeIfPresent(DifficultyMode.self, forKey: .preferredDifficulty) ?? .medium
        commitment = try container.decodeIfPresent(CommitmentLevel.self, forKey: .commitment)
        hasCompletedOnboarding = try container.decodeIfPresent(Bool.self, forKey: .hasCompletedOnboarding) ?? false
    }
}

// MARK: - Enums

enum AgeRange: String, Codable, CaseIterable {
    case range14_24 = "14-24"
    case range25_34 = "25-34"
    case range35_44 = "35-44"
    case range45_54 = "45-54"
    case range55Plus = "55+"
    
    var displayText: String {
        localizedDisplayText
    }
}

enum UserGoal: String, Codable, CaseIterable {
    // Hedef Belirleme (Achieve)
    case putGodFirst = "put_god_first"
    case buildPrayerHabit = "build_prayer_habit"
    case deepenRelationship = "deepen_relationship"
    case findPeace = "find_peace"
    case startWithIntention = "start_with_intention"
    case centerQuran = "center_quran"
    case liveSunnah = "live_sunnah"
    case avoidWaste = "avoid_waste"
    
    var displayText: String {
        localizedDisplayText
    }
}

enum BiggerVision: String, Codable, CaseIterable {
    case tevekkul = "tevekkul"
    case istikamet = "istikamet"
    case infak = "infak"
    case nefsMucadelesi = "nefs_mucadelesi"
    case prophetCharacter = "prophet_character"
    
    var displayText: String {
        localizedDisplayText
    }
}

enum SpiritualState: String, Codable, CaseIterable {
    case fluctuating = "fluctuating"
    case distant = "distant"
    case newStart = "new_start"
    case close = "close"
    
    var displayText: String {
        localizedDisplayText
    }
}

enum Blocker: String, Codable, CaseIterable {
    case phoneDistraction = "phone_distraction"
    case lossOfKhushu = "loss_of_khushu"
    case spiritualEmptiness = "spiritual_emptiness"
    case worldlyBusyness = "worldly_busyness"
    case fajrDifficulty = "fajr_difficulty"
    
    var displayText: String {
        localizedDisplayText
    }
}

enum RootStruggle: String, Codable, CaseIterable {
    case nafsaniDesires = "nafsani_desires"
    case futureAnxiety = "future_anxiety"
    case heartHardness = "heart_hardness"
    case arrogance = "arrogance"
    case pastGuilt = "past_guilt"
    
    var displayText: String {
        localizedDisplayText
    }
}

enum Madhhab: String, Codable, CaseIterable {
    case hanafi = "hanafi"
    case shafii = "shafii"
    case malikiHanbali = "maliki_hanbali"
    case general = "general"
    
    var displayText: String {
        localizedDisplayText
    }
}

enum Sex: String, Codable, CaseIterable {
    case male = "male"
    case female = "female"
    
    var displayText: String {
        localizedDisplayText
    }
}

enum Mood: String, Codable {
    case good = "good"
    case great = "great"
    case bad = "bad"
    
    var displayText: String {
        localizedDisplayText
    }
    
    var emoji: String {
        switch self {
        case .good: return "🙂"
        case .great: return "😊"
        case .bad: return "☹️"
        }
    }
}

enum CommitmentLevel: String, Codable, CaseIterable {
    case veryCommitted = "very_committed"
    case committed = "committed"
    case somewhatCommitted = "somewhat_committed"
    case lessCommitted = "less_committed"
    case justTrying = "just_trying"
    
    var displayText: String {
        localizedDisplayText
    }
}

enum PhoneUsageRange: String, Codable, CaseIterable {
    case oneToTwo = "1-2"
    case twoToThree = "2-3"
    case threeToFour = "3-4"
    case fourToFive = "4-5"
    case fiveToSix = "5-6"
    case sixPlus = "6+"
    
    var displayText: String {
        localizedDisplayText
    }
    
    var averageHours: Double {
        switch self {
        case .oneToTwo: return 1.5
        case .twoToThree: return 2.5
        case .threeToFour: return 3.5
        case .fourToFive: return 4.5
        case .fiveToSix: return 5.5
        case .sixPlus: return 7.0
        }
    }
}
