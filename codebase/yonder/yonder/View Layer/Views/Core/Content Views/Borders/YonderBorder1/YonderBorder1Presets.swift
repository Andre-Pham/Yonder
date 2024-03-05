//
//  YonderBorder1Presets.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import Foundation

enum YonderBorder1Presets {
    
    // Sides
    static let border1Top = YonderImage("Border1Top")
    static let border1Bottom = YonderImage("Border1Bottom")
    static let border1Left = YonderImage("Border1Left")
    static let border1Right = YonderImage("Border1Right")
    
    // Corners
    static let border1TopLeft = YonderImage("Border1TopLeft")
    static let border1TopRight = YonderImage("Border1TopRight")
    static let border1BottomLeft = YonderImage("Border1BottomLeft")
    static let border1BottomRight = YonderImage("Border1BottomRight")
    
    // Insets
    static let border1TopLeftInset = YonderImage("Border1TopLeftInset")
    static let border1TopRightInset = YonderImage("Border1TopRightInset")
    static let border1BottomLeftInset = YonderImage("Border1BottomLeftInset")
    static let border1BottomRightInset = YonderImage("Border1BottomRightInset")
    
    // Colors
    // - None
    
    // Dimensions
    static var leftThickness: Double {
        return self.border1Left.width
    }
    static var rightThickness: Double {
        return self.border1Right.width
    }
    static var topThickness: Double {
        return self.border1Top.height
    }
    static var bottomThickness: Double {
        return self.border1Bottom.height
    }
    
}
