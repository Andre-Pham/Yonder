//
//  YonderBorder3Presets.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder3Presets {
    
    // Colors
    static let fillColor = Color("Border3#364164")
    static let bottomRiseColor = Color("Border3#202A47")
    static let outlineColor = Color("Border3#161F3A")
    
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
        return self.outlineThickness + self.bottomRiseThickness
    }
    
}
