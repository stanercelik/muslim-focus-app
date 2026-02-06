//
//  LocalizationHelpers.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import Foundation
import SwiftUI

enum L10n {
    static func text(_ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }

    static func markdown(_ key: String, _ args: CVarArg...) -> AttributedString {
        let format = NSLocalizedString(key, comment: "")
        let formatted = String(format: format, locale: Locale.current, arguments: args)
        let attributed = (try? AttributedString(markdown: formatted)) ?? AttributedString(formatted)
        var styled = applyBaseColor(in: attributed, color: .appTextPrimary)
        styled = highlightStrongEmphasis(in: styled, color: .appPrimary)
        styled = styleParenthetical(in: styled, tokens: ["(cc)", "(SWT)", "(sav)", "(PBUH)"])
        return styled
    }

    private static func highlightStrongEmphasis(in attributed: AttributedString, color: Color) -> AttributedString {
        var mutable = attributed
        for run in mutable.runs {
            guard run.inlinePresentationIntent?.contains(.stronglyEmphasized) == true else { continue }
            let range = run.range
            mutable[range].foregroundColor = color
        }
        return mutable
    }

    private static func applyBaseColor(in attributed: AttributedString, color: Color) -> AttributedString {
        var mutable = attributed
        let fullRange = mutable.startIndex..<mutable.endIndex
        mutable[fullRange].foregroundColor = color
        return mutable
    }

    private static func styleParenthetical(in attributed: AttributedString, tokens: [String]) -> AttributedString {
        var mutable = attributed
        for token in tokens {
            var searchStart = mutable.startIndex
            while let range = mutable[searchStart...].range(of: token) {
                mutable[range].foregroundColor = Color.appTextPrimary.opacity(0.6)
                searchStart = range.upperBound
            }
        }
        return mutable
    }
}
