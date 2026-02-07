//
//  ContentPack.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import Foundation

struct ContentPack: Codable {
    let packVersion: String
    let generatedAt: String
    let counts: ContentCounts
    let sources: [GlobalSourceRef]
    let cards: [ContentCard]
}

struct ContentCounts: Codable {
    let surah: Int
    let ayah: Int
    let dua: Int
}

struct GlobalSourceRef: Codable {
    let id: String
    let name: String
    let url: String?
    let license: String?
    let file: String?
    let note: String?
}

struct ContentCard: Codable, Identifiable {
    let id: String
    let type: ContentCardType
    let title: String
    let lengthBucket: ContentLengthBucket
    let moodLevels: [MoodLevel]
    let moodTags: [MoodTag]
    let topicTags: [String]
    let content: CardContent
    let source: SourceRef
}

enum ContentCardType: String, Codable {
    case ayah
    case surah
    case dua
}

enum ContentLengthBucket: String, Codable {
    case xs
    case s
    case m
    case l
}

struct CardContent: Codable {
    let verses: [CardVerseLine]?
    let dua: CardDuaBody?
}

struct CardVerseLine: Codable, Identifiable {
    let verseKey: String
    let arabic: String
    let transliterationAscii: String
    let translation: CardTranslation

    var id: String {
        verseKey
    }
}

struct CardDuaBody: Codable {
    let arabic: String
    let transliterationAscii: String
    let translation: CardTranslation
}

struct CardTranslation: Codable {
    let en: String
    let tr: String
}

struct SourceRef: Codable {
    let quranRef: String?
    let hisnCategory: String?
    let hadithRef: String?
    let sourceName: String?
    let sourceUrl: String?
}
