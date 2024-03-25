//
//  YonderBorder1Presets.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import Foundation

enum YonderBorder1Presets {
    
    // Sides
    static let topBorder = YonderImage("Border1Top")
    static let bottomBorder = YonderImage("Border1Bottom")
    static let leftBorder = YonderImage("Border1Left")
    static let rightBorder = YonderImage("Border1Right")
    
    // Corners
    static let topLeftCorner = YonderImage("Border1TopLeft")
    static let topRightCorner = YonderImage("Border1TopRight")
    static let bottomLeftCorner = YonderImage("Border1BottomLeft")
    static let bottomRightCorner = YonderImage("Border1BottomRight")
    
    // Insets
    static let topLeftInset = YonderImage("Border1TopLeftInset")
    static let topRightInset = YonderImage("Border1TopRightInset")
    static let bottomLeftInset = YonderImage("Border1BottomLeftInset")
    static let bottomRightInset = YonderImage("Border1BottomRightInset")
    
    // Colors
    // - None
    
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
