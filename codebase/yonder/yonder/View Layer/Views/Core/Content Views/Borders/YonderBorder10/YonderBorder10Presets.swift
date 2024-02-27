//
//  YonderBorder10Presets.swift
//  yonder
//
//  Created by Andre Pham on 27/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder10Presets {
    
    // Colors
    static let inlineColor = Color("Border10#528FF5")
    static let fillColor = Color("Border10#346CC3")
    static let bottomRiseColor = Color("Border10#274B99")
    static let outlineColor = Color("Border10#122D58")
    
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
