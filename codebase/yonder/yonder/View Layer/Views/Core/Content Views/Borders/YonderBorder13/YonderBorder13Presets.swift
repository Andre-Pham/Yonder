//
//  YonderBorder13Presets.swift
//  yonder
//
//  Created by Andre Pham on 25/3/2024.
//

import Foundation
import SwiftUI

enum YonderBorder13Presets {
    
    // Sides
    static let topBorder = YonderImage("Border13Top")
    static let bottomBorder = YonderImage("Border13Bottom")
    static let leftBorder = YonderImage("Border13Left")
    static let rightBorder = YonderImage("Border13Right")
    
    // Corners
    static let topLeftCorner = YonderImage("Border13TopLeft")
    static let topRightCorner = YonderImage("Border13TopRight")
    static let bottomLeftCorner = YonderImage("Border13BottomLeft")
    static let bottomRightCorner = YonderImage("Border13BottomRight")
    
    // Insets
    static let topLeftInset = YonderImage("Border13Inset")
    static let topRightInset = YonderImage("Border13Inset")
    static let bottomLeftInset = YonderImage("Border13Inset")
    static let bottomRightInset = YonderImage("Border13Inset")
    
    // Colors
    static let fillColor = Color("Border13#364164")
    
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
