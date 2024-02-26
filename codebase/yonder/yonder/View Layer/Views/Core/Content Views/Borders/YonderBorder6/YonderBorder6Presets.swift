//
//  YonderBorder6Presets.swift
//  yonder
//
//  Created by Andre Pham on 19/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder6Presets {
    
    // Colors
    static let inlineColor = Color("Border6#9966E5")
    static let fillColor = Color("Border6#7247B6")
    static let bottomRiseColor = Color("Border6#572E88")
    static let outlineColor = Color("Border6#2E194F")
    
    // Dimensions
    static let outlineThickness = 4.0
    static let bottomRiseThickness = 12.0
    static var leftThickness: Double {
        return self.outlineThickness
    }
    static var rightThickness: Double {
        return self.outlineThickness
    }
    static var topThickness: Double {
        return self.outlineThickness
    }
    static var bottomThickness: Double {
        return self.outlineThickness
    }
    
}

