//
//  YonderBorder9Presets.swift
//  yonder
//
//  Created by Andre Pham on 26/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder9Presets {
    
    // Colors
    static let inlineColor = Color("Border9#CF424C")
    static let fillColor = Color("Border9#A0242E")
    static let bottomRiseColor = Color("Border9#721111")
    static let outlineColor = Color("Border9#490306")
    
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
