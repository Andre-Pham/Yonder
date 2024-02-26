//
//  YonderBorder5Presets.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder5Presets {
    
    // Colors
    static let inlineColor = Color("Border5#B57B63")
    static let fillColor = Color("Border5#965F56")
    static let bottomRiseColor = Color("Border5#71484A")
    static let outlineColor = Color("Border5#3A1A16")
    
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
