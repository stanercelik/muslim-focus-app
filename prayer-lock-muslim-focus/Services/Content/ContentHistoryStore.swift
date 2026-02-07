//
//  ContentHistoryStore.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import Foundation

struct ContentServeRecord: Codable {
    let cardID: String
    let cardType: ContentCardType
    let servedAt: TimeInterval
}

final class ContentHistoryStore {
    private let recordsKey = "content_history_records_v1"
    private let weeklySurahKey = "content_history_weekly_surah_v1"

    func recentCardIDs(withinDays days: Int, now: Date = .now) -> Set<String> {
        let threshold = now.addingTimeInterval(TimeInterval(-days * 24 * 60 * 60)).timeIntervalSince1970
        return Set(loadRecords().filter { $0.servedAt >= threshold }.map(\.cardID))
    }

    func record(_ card: ContentCard, now: Date = .now) {
        var records = loadRecords()
        records.append(
            ContentServeRecord(
                cardID: card.id,
                cardType: card.type,
                servedAt: now.timeIntervalSince1970
            )
        )

        let keepThreshold = now.addingTimeInterval(TimeInterval(-30 * 24 * 60 * 60)).timeIntervalSince1970
        records = records.filter { $0.servedAt >= keepThreshold }
        saveRecords(records)

        guard card.type == .surah else { return }
        var map = loadWeeklySurahCount()
        let weekKey = currentWeekKey(now: now)
        map[weekKey, default: 0] += 1
        saveWeeklySurahCount(map)
    }

    func currentWeekSurahCount(now: Date = .now) -> Int {
        loadWeeklySurahCount()[currentWeekKey(now: now), default: 0]
    }

    private func currentWeekKey(now: Date) -> String {
        let calendar = Calendar(identifier: .iso8601)
        let year = calendar.component(.yearForWeekOfYear, from: now)
        let week = calendar.component(.weekOfYear, from: now)
        return "\(year)-W\(week)"
    }

    private func loadRecords() -> [ContentServeRecord] {
        guard
            let data = UserDefaults.standard.data(forKey: recordsKey),
            let decoded = try? JSONDecoder().decode([ContentServeRecord].self, from: data)
        else {
            return []
        }
        return decoded
    }

    private func saveRecords(_ records: [ContentServeRecord]) {
        guard let data = try? JSONEncoder().encode(records) else { return }
        UserDefaults.standard.set(data, forKey: recordsKey)
    }

    private func loadWeeklySurahCount() -> [String: Int] {
        guard
            let data = UserDefaults.standard.data(forKey: weeklySurahKey),
            let decoded = try? JSONDecoder().decode([String: Int].self, from: data)
        else {
            return [:]
        }
        return decoded
    }

    private func saveWeeklySurahCount(_ map: [String: Int]) {
        guard let data = try? JSONEncoder().encode(map) else { return }
        UserDefaults.standard.set(data, forKey: weeklySurahKey)
    }
}
