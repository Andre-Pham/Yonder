//
//  YonderBorder4Presets.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder4Presets {
    
    // Colors
    static let fillColor = Color("Border4#000928")
    static let outlineColor = Color("Border4#364164")
    
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
