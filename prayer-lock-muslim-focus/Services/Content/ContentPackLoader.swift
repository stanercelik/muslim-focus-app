//
//  ContentPackLoader.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import Foundation

enum ContentPackLoaderError: Error {
    case fileNotFound
    case decodeFailed
}

struct ContentPackLoader {
    func loadPack(named fileName: String = "content_pack_v0.multi") throws -> ContentPack {
        let candidateURLs: [URL?] = [
            Bundle.main.url(forResource: fileName, withExtension: "json", subdirectory: "Content"),
            Bundle.main.url(forResource: fileName, withExtension: "json"),
        ]

        guard let fileURL = candidateURLs.compactMap({ $0 }).first else {
            throw ContentPackLoaderError.fileNotFound
        }

        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        guard let pack = try? decoder.decode(ContentPack.self, from: data) else {
            throw ContentPackLoaderError.decodeFailed
        }
        return pack
    }
}
