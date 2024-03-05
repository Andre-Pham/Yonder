//
//  YonderBorder7Presets.swift
//  yonder
//
//  Created by Andre Pham on 26/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder7Presets {
    
    // Colors
    static let fillColor = Color("Border7#19234C")
    static let bottomRiseColor = Color("Border7#0B1643")
    static let outlineColor = Color("Border7#010B36")
    
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
