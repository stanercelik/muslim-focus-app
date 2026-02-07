//
//  ContentTypes.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import Foundation

enum DifficultyMode: String, Codable, CaseIterable {
    case easy
    case medium
    case hard
}

enum PrimaryLanguage: String, Codable, CaseIterable {
    case en
    case tr
}

enum MoodLevel: String, Codable, CaseIterable {
    case low
    case mid
    case high
}

enum MoodTag: String, Codable, CaseIterable {
    case anxiety
    case focus
    case gratitude
    case guilt
    case patience
    case guidance
}

struct LockMoodSelection: Codable, Equatable {
    var moodLevel: MoodLevel?
    var moodTag: MoodTag?
}

struct UserPreferences: Codable, Equatable {
    var difficultyMode: DifficultyMode = .medium
    var languagePrimary: PrimaryLanguage = .en
}
