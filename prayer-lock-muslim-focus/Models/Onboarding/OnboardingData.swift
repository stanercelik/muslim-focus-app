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
    var commitment: CommitmentLevel?
    var hasCompletedOnboarding: Bool = false
}

// MARK: - Enums

enum AgeRange: String, Codable, CaseIterable {
    case range14_24 = "14-24"
    case range25_34 = "25-34"
    case range35_44 = "35-44"
    case range45_54 = "45-54"
    case range55Plus = "55+"
    
    var displayText: String {
        switch self {
        case .range14_24: return "14-24"
        case .range25_34: return "25-34"
        case .range35_44: return "35-44"
        case .range45_54: return "45-54"
        case .range55Plus: return "55+"
        }
    }
}

enum UserGoal: String, Codable, CaseIterable {
    // Set 1 (E08)
    case prioritizeAllah = "prioritize_allah"
    case regularWorship = "regular_worship"
    case strengthenConnection = "strengthen_connection"
    case findPeace = "find_peace"
    case startWithIntention = "start_with_intention"
    case calmMind = "calm_mind"
    
    // Set 2 (E09)
    case readQuran = "read_quran"
    case keepHeartAlive = "keep_heart_alive"
    case strengthenIstikamet = "strengthen_istikamet"
    case prayForGuidance = "pray_for_guidance"
    case trustAllah = "trust_allah"
    case fightSins = "fight_sins"
    case morningEveningRoutine = "morning_evening_routine"
    
    var displayText: String {
        switch self {
        case .prioritizeAllah: return "Allah'ı öncelemek, telefonu değil"
        case .regularWorship: return "düzenli ibadet alışkanlığı"
        case .strengthenConnection: return "Allah ile bağımı güçlendirmek"
        case .findPeace: return "kaotik bir dünyada huzur bulmak"
        case .startWithIntention: return "güne niyetle başlamak"
        case .calmMind: return "zihnimi sakinleştirmek"
        case .readQuran: return "Kur'an'ı daha düzenli okumak"
        case .keepHeartAlive: return "zikirle kalbimi diri tutmak"
        case .strengthenIstikamet: return "istikametimi güçlendirmek"
        case .prayForGuidance: return "büyük bir karar için dua ile yön bulmak"
        case .trustAllah: return "Allah'a daha çok güvenmek (tevekkül)"
        case .fightSins: return "günahlarla mücadelede daha güçlü olmak"
        case .morningEveningRoutine: return "sabah/akşam rutinini oturtmak"
        }
    }
    
    var iconName: String {
        switch self {
        case .prioritizeAllah: return "star.fill"
        case .regularWorship: return "calendar"
        case .strengthenConnection: return "heart.fill"
        case .findPeace: return "leaf.fill"
        case .startWithIntention: return "sunrise.fill"
        case .calmMind: return "brain.head.profile"
        case .readQuran: return "book.fill"
        case .keepHeartAlive: return "sparkles"
        case .strengthenIstikamet: return "arrow.up.right"
        case .prayForGuidance: return "signpost.right.fill"
        case .trustAllah: return "hand.raised.fill"
        case .fightSins: return "shield.fill"
        case .morningEveningRoutine: return "clock.fill"
        }
    }
}

enum BiggerVision: String, Codable, CaseIterable {
    case patienceAndTrust = "patience_trust"
    case liveWithIstikamet = "live_istikamet"
    case beUseful = "be_useful"
    case centerQuran = "center_quran"
    case peacefulHeart = "peaceful_heart"
    
    var displayText: String {
        switch self {
        case .patienceAndTrust: return "zor zamanlarda sabır ve tevekkül"
        case .liveWithIstikamet: return "imanımı davranışımla yaşamak (istikamet)"
        case .beUseful: return "Allah'ın verdikleriyle faydalı olmak"
        case .centerQuran: return "Kur'an'ı merkeze almak"
        case .peacefulHeart: return "kalbimde huzur ve sükunet"
        }
    }
}

enum SpiritualState: String, Codable, CaseIterable {
    case upAndDown = "up_down"
    case distant = "distant"
    case restarting = "restarting"
    case closeAndRegular = "close_regular"
    
    var displayText: String {
        switch self {
        case .upAndDown: return "inişli çıkışlı"
        case .distant: return "son zamanlarda biraz uzak"
        case .restarting: return "yeniden başlıyorum / toparlıyorum"
        case .closeAndRegular: return "yakın ve düzenli"
        }
    }
}

enum Blocker: String, Codable, CaseIterable {
    case phoneSocialMedia = "phone_social"
    case lossOfFocus = "loss_focus"
    case lowMotivation = "low_motivation"
    case noTime = "no_time"
    case procrastination = "procrastination"
    case anxiety = "anxiety"
    
    var displayText: String {
        switch self {
        case .phoneSocialMedia: return "telefon & sosyal medya"
        case .lossOfFocus: return "odak kaybı / dalgınlık"
        case .lowMotivation: return "motivasyon düşük"
        case .noTime: return "yoğunluk & zaman yok"
        case .procrastination: return "ertelemek"
        case .anxiety: return "kaygı / zihnim susmuyor"
        }
    }
}

enum RootStruggle: String, Codable, CaseIterable {
    case obsessiveThoughts = "obsessive_thoughts"
    case constantWorry = "constant_worry"
    case loneliness = "loneliness"
    case angerResentment = "anger_resentment"
    case overconfidence = "overconfidence"
    case cantBreakHabits = "cant_break_habits"
    
    var displayText: String {
        switch self {
        case .obsessiveThoughts: return "vesvese / zihinsel yük"
        case .constantWorry: return "sürekli endişe"
        case .loneliness: return "yalnızlık"
        case .angerResentment: return "öfke / kırgınlık"
        case .overconfidence: return "nefsime fazla güvenmek"
        case .cantBreakHabits: return "alışkanlıklarımı bırakamamak"
        }
    }
}

enum Madhhab: String, Codable, CaseIterable {
    case general = "general"
    case hanafi = "hanafi"
    case shafii = "shafii"
    case maliki = "maliki"
    case hanbali = "hanbali"
    case other = "other"
    
    var displayText: String {
        switch self {
        case .general: return "genel (mezhep belirtmek istemiyorum)"
        case .hanafi: return "hanefi"
        case .shafii: return "şafii"
        case .maliki: return "maliki"
        case .hanbali: return "hanbeli"
        case .other: return "diğer / emin değilim"
        }
    }
}

enum Sex: String, Codable {
    case male = "male"
    case female = "female"
    
    var displayText: String {
        switch self {
        case .male: return "erkek"
        case .female: return "kadın"
        }
    }
}

enum Mood: String, Codable {
    case good = "good"
    case great = "great"
    case bad = "bad"
    
    var displayText: String {
        switch self {
        case .good: return "iyi"
        case .great: return "çok iyi"
        case .bad: return "zor"
        }
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
        switch self {
        case .veryCommitted: return "çok kararlıyım"
        case .committed: return "kararlıyım"
        case .somewhatCommitted: return "biraz kararlıyım"
        case .lessCommitted: return "az kararlıyım"
        case .justTrying: return "şimdilik deniyorum"
        }
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
        switch self {
        case .oneToTwo: return "1-2 saat"
        case .twoToThree: return "2-3 saat"
        case .threeToFour: return "3-4 saat"
        case .fourToFive: return "4-5 saat"
        case .fiveToSix: return "5-6 saat"
        case .sixPlus: return "6+ saat"
        }
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
