//
//  YonderBorder11Presets.swift
//  yonder
//
//  Created by Andre Pham on 27/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder11Presets {
    
    // Colors
    static let inlineColor = Color("Border11#22BC8B")
    static let fillColor = Color("Border11#0C9365")
    static let bottomRiseColor = Color("Border11#016C51")
    static let outlineColor = Color("Border11#00402A")
    
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
