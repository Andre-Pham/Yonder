//
//  YonderBorder2Presets.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import Foundation
import SwiftUI

enum YonderBorder2Presets {
    
    // Sides
    static let topBorder = YonderImage("Border2Top")
    static let bottomBorder = YonderImage("Border2Bottom")
    static let leftBorder = YonderImage("Border2Left")
    static let rightBorder = YonderImage("Border2Right")
    
    // Corners
    static let topLeftCorner = YonderImage("Border2TopLeft")
    static let topRightCorner = YonderImage("Border2TopRight")
    static let bottomLeftCorner = YonderImage("Border2BottomLeft")
    static let bottomRightCorner = YonderImage("Border2BottomRight")
    
    // Insets
    static let topLeftInset = YonderImage("Border2TopLeftInset")
    static let topRightInset = YonderImage("Border2TopRightInset")
    static let bottomLeftInset = YonderImage("Border2BottomLeftInset")
    static let bottomRightInset = YonderImage("Border2BottomRightInset")
    
    // Colors
    static let fillColor = Color("Border2#364164")
    
    // Dimensions
    static var leftThickness: Double {
        return self.leftBorder.width
    }
    static var rightThickness: Double {
        return self.rightBorder.width
    }
    static var topThickness: Double {
        return self.topBorder.height
    }
    static var bottomThickness: Double {
        return self.bottomBorder.height
    }
    
}
