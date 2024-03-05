//
//  YonderBorder8Presets.swift
//  yonder
//
//  Created by Andre Pham on 26/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder8Presets {
    
    // Colors
    static let outlineColor = Color("Border8#9966E5")
    static let fillColor = Color("Border8#2E194F")
    
    // Dimensions
    static let outlineThickness = 4.0
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
