//
//  ColorExtensions.swift
//  prayer-lock-muslim-focus
//
//  Created by Taner Çelik on 4.02.2026.
//

import SwiftUI

extension Color {
    // Primary colors from design system
    static let appPrimaryBackground = Color("PrimaryBackground")
    static let appSecondaryBackground = Color(red: 0.965, green: 0.969, blue: 0.973) // #F6F7F8
    
    // Accent colors
    static let appAccent = Color("AccentColor") // #FF6A2B
    static let appSecondaryAccent = Color(red: 1.0, green: 0.690, blue: 0.537) // #FFB089
    
    // Text colors
    static let appTextOnDark = Color.white
    static let appTextOnLight = Color(red: 0.051, green: 0.059, blue: 0.071) // #0D0F12
    static let appMutedText = Color(red: 0.420, green: 0.447, blue: 0.502) // #6B7280
    
    // Utility colors
    static let appDivider = Color(red: 0.906, green: 0.914, blue: 0.925) // #E7E9EC
    static let appSuccess = Color(red: 0.133, green: 0.773, blue: 0.369) // #22C55E
    static let appDanger = Color(red: 0.937, green: 0.267, blue: 0.267) // #EF4444
}
