//
//  AnalyticsTracker.swift
//  prayer-lock-muslim-focus
//
//  Created by Codex on 7.02.2026.
//

import Foundation

protocol AnalyticsTracking {
    func track(_ event: String, properties: [String: String])
}

struct NoopAnalyticsTracker: AnalyticsTracking {
    func track(_ event: String, properties: [String: String] = [:]) {
        #if DEBUG
        print("[Analytics] \(event) \(properties)")
        #endif
    }
}
