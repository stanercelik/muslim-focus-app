//
//  UserPreferencesStore.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import Foundation
import Combine

@MainActor
final class UserPreferencesStore: ObservableObject {
    static let shared = UserPreferencesStore()

    @Published private(set) var preferences: UserPreferences

    private let key = "user_preferences_v1"

    private init() {
        if
            let data = UserDefaults.standard.data(forKey: key),
            let decoded = try? JSONDecoder().decode(UserPreferences.self, from: data)
        {
            preferences = decoded
        } else {
            preferences = UserPreferences()
        }
    }

    func setDifficultyMode(_ difficultyMode: DifficultyMode) {
        preferences.difficultyMode = difficultyMode
        persist()
    }

    func setPrimaryLanguage(_ language: PrimaryLanguage) {
        preferences.languagePrimary = language
        persist()
    }

    private func persist() {
        guard let encoded = try? JSONEncoder().encode(preferences) else { return }
        UserDefaults.standard.set(encoded, forKey: key)
    }
}
