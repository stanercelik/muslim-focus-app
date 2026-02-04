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
        switch self {
        case .putGodFirst: return "🤲 Allah'ı (cc) her şeyin önüne koymak, telefonun değil."
        case .buildPrayerHabit: return "🕌 5 vakit namazda sarsılmaz bir istikrar kazanmak."
        case .deepenRelationship: return "❤️ Rabbimle olan bağımı ve muhabbetimi artırmak."
        case .findPeace: return "✨ Dünyalık telaşlar içinde sekine (huzur) bulmak."
        case .startWithIntention: return "🎯 Güne niyetle ve sabah zikriyle başlamak."
        case .centerQuran: return "📖 Kur'an-ı Kerim'i hayatımın merkezine almak."
        case .liveSunnah: return "🌙 Sünnet-i Seniyye üzere bir yaşam sürmek."
        case .avoidWaste: return "🚫 Gıybet ve malayani (faydasız) işlerden uzaklaşmak."
        }
    }
}

enum BiggerVision: String, Codable, CaseIterable {
    case tevekkul = "tevekkul"
    case istikamet = "istikamet"
    case infak = "infak"
    case nefsMucadelesi = "nefs_mucadelesi"
    case prophetCharacter = "prophet_character"
    
    var displayText: String {
        switch self {
        case .tevekkul: return "🤝 Zorluklarda tam bir tevekkül ve rıza göstermek."
        case .istikamet: return "💯 Özü sözü bir, dosdoğru bir Müslüman olmak (İstikamet)."
        case .infak: return "🙌 Allah'ın verdiği nimetleri O'nun rızası için infak etmek."
        case .nefsMucadelesi: return "🛡️ Nefsimle mücadelede irademi güçlendirmek."
        case .prophetCharacter: return "🌟 Ahlakımı Peygamber Efendimiz'in (sav) ahlakıyla güzelleştirmek."
        }
    }
}

enum SpiritualState: String, Codable, CaseIterable {
    case fluctuating = "fluctuating"
    case distant = "distant"
    case newStart = "new_start"
    case close = "close"
    
    var displayText: String {
        switch self {
        case .fluctuating: return "🎢 İmanım bazen artıyor, bazen azalıyor."
        case .distant: return "😔 Son zamanlarda kendimi Rabbimden uzak hissediyorum."
        case .newStart: return "🌱 Tövbe ile yeni bir başlangıç yapıyorum."
        case .close: return "🙏 Hamdolsun, yakın ve istikrarlı bir bağım var."
        }
    }
}

enum Blocker: String, Codable, CaseIterable {
    case phoneDistraction = "phone_distraction"
    case lossOfKhushu = "loss_of_khushu"
    case spiritualEmptiness = "spiritual_emptiness"
    case worldlyBusyness = "worldly_busyness"
    case fajrDifficulty = "fajr_difficulty"
    
    var displayText: String {
        switch self {
        case .phoneDistraction: return "📱 Telefon ve sosyal medya dağınıklığı."
        case .lossOfKhushu: return "🧠 Namazda huşu kaybı ve zihnin dağılması."
        case .spiritualEmptiness: return "😥 Manevi boşluk veya motivasyon düşüklüğü (Gaflet)."
        case .worldlyBusyness: return "⏰ Dünya işleri ve vakit darlığı."
        case .fajrDifficulty: return "💤 Sabah namazına uyanmakta zorlanmak."
        }
    }
}

enum RootStruggle: String, Codable, CaseIterable {
    case nafsaniDesires = "nafsani_desires"
    case futureAnxiety = "future_anxiety"
    case heartHardness = "heart_hardness"
    case arrogance = "arrogance"
    case pastGuilt = "past_guilt"
    
    var displayText: String {
        switch self {
        case .nafsaniDesires: return "🔥 Nefsi arzular ve harama bakmak."
        case .futureAnxiety: return "😥 Gelecek kaygısı ve yersiz vesveseler."
        case .heartHardness: return "😔 Kalp katılığı ve manevi yalnızlık."
        case .arrogance: return "💪 Kibir veya kendine aşırı güvenme."
        case .pastGuilt: return "🌑 Geçmiş hataların verdiği suçluluk duygusu."
        }
    }
}

enum Madhhab: String, Codable, CaseIterable {
    case hanafi = "hanafi"
    case shafii = "shafii"
    case malikiHanbali = "maliki_hanbali"
    case general = "general"
    
    var displayText: String {
        switch self {
        case .hanafi: return "Hanefi"
        case .shafii: return "Şafii"
        case .malikiHanbali: return "Maliki / Hanbeli"
        case .general: return "Genel / Mezhep Belirtmek İstemiyorum"
        }
    }
}

enum Sex: String, Codable, CaseIterable {
    case male = "male"
    case female = "female"
    
    var displayText: String {
        switch self {
        case .male: return "Erkek"
        case .female: return "Kadın"
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
