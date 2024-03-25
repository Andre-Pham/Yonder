//
//  YonderBorder12Presets.swift
//  yonder
//
//  Created by Andre Pham on 25/3/2024.
//

import Foundation
import SwiftUI

enum YonderBorder12Presets {
    
    // Sides
    static let topBorder = YonderImage("Border12Top")
    static let bottomBorder = YonderImage("Border12Bottom")
    static let leftBorder = YonderImage("Border12Left")
    static let rightBorder = YonderImage("Border12Right")
    
    // Corners
    static let topLeftCorner = YonderImage("Border12TopLeft")
    static let topRightCorner = YonderImage("Border12TopRight")
    static let bottomLeftCorner = YonderImage("Border12BottomLeft")
    static let bottomRightCorner = YonderImage("Border12BottomRight")
    
    // Insets
    static let topLeftInset = YonderImage("Border12Inset")
    static let topRightInset = YonderImage("Border12Inset")
    static let bottomLeftInset = YonderImage("Border12Inset")
    static let bottomRightInset = YonderImage("Border12Inset")
    
    // Colors
    static let fillColor = Color("Border12#C0765D")
    
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
