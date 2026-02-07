//
//  ContentSelector.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import Foundation

struct DifficultyMix {
    let typeWeights: [ContentCardType: Double]
    let preferredLengths: Set<ContentLengthBucket>

    static func forDifficulty(_ difficulty: DifficultyMode) -> DifficultyMix {
        switch difficulty {
        case .easy:
            return DifficultyMix(
                typeWeights: [.ayah: 0.50, .dua: 0.40, .surah: 0.10],
                preferredLengths: [.xs, .s]
            )
        case .medium:
            return DifficultyMix(
                typeWeights: [.ayah: 0.45, .dua: 0.45, .surah: 0.10],
                preferredLengths: [.s, .m]
            )
        case .hard:
            return DifficultyMix(
                typeWeights: [.ayah: 0.35, .dua: 0.55, .surah: 0.10],
                preferredLengths: [.m, .l]
            )
        }
    }
}

final class ContentSelector {
    private let historyStore: ContentHistoryStore
    private let tracker: AnalyticsTracking
    private let weeklySurahLimit = 2

    init(historyStore: ContentHistoryStore = ContentHistoryStore(), tracker: AnalyticsTracking = NoopAnalyticsTracker()) {
        self.historyStore = historyStore
        self.tracker = tracker
    }

    func selectCard(
        from pack: ContentPack,
        moodSelection: LockMoodSelection,
        difficulty: DifficultyMode,
        preferredType: ContentCardType? = nil
    ) -> ContentCard? {
        let recentIDs = historyStore.recentCardIDs(withinDays: 7)
        let mix = DifficultyMix.forDifficulty(difficulty)

        let moodScoped = filterByMood(pack.cards, selection: moodSelection)
        var candidates = moodScoped.filter { !recentIDs.contains($0.id) }
        if candidates.isEmpty {
            candidates = moodScoped
        }
        if candidates.isEmpty {
            candidates = pack.cards
        }

        if let preferredType {
            let typed = candidates.filter { $0.type == preferredType }
            if typed.isEmpty == false {
                candidates = typed
            }
        } else {
            candidates = preferWeightedType(candidates: candidates, mix: mix)
        }

        let lengthScoped = candidates.filter { mix.preferredLengths.contains($0.lengthBucket) }
        if lengthScoped.isEmpty == false {
            candidates = lengthScoped
        }

        if historyStore.currentWeekSurahCount() >= weeklySurahLimit {
            let noSurah = candidates.filter { $0.type != .surah }
            if noSurah.isEmpty == false {
                candidates = noSurah
            }
        }

        guard let selected = candidates.randomElement() else { return nil }
        historyStore.record(selected)
        tracker.track(
            "content_card_served",
            properties: [
                "card_id": selected.id,
                "card_type": selected.type.rawValue,
                "difficulty": difficulty.rawValue,
                "mood_level": moodSelection.moodLevel?.rawValue ?? "unset",
                "mood_tag": moodSelection.moodTag?.rawValue ?? "unset",
            ]
        )
        return selected
    }

    private func filterByMood(_ cards: [ContentCard], selection: LockMoodSelection) -> [ContentCard] {
        guard let level = selection.moodLevel else { return cards }
        var filtered = cards.filter { $0.moodLevels.contains(level) }
        if let tag = selection.moodTag {
            let byTag = filtered.filter { $0.moodTags.contains(tag) }
            if byTag.isEmpty == false {
                filtered = byTag
            }
        }
        return filtered
    }

    private func preferWeightedType(candidates: [ContentCard], mix: DifficultyMix) -> [ContentCard] {
        let availableTypes = Set(candidates.map(\.type))
        let availableWeights = mix.typeWeights.filter { availableTypes.contains($0.key) }
        guard let selectedType = weightedRandomType(availableWeights) else { return candidates }
        let typed = candidates.filter { $0.type == selectedType }
        return typed.isEmpty ? candidates : typed
    }

    private func weightedRandomType(_ weights: [ContentCardType: Double]) -> ContentCardType? {
        let total = weights.values.reduce(0, +)
        guard total > 0 else { return nil }

        var target = Double.random(in: 0..<total)
        for (type, weight) in weights {
            target -= weight
            if target <= 0 {
                return type
            }
        }
        return weights.keys.first
    }
}
