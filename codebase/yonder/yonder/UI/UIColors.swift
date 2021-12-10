//
//  UIColors.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

extension Color {
    
    static let Yonder = Color.YonderColors()
    
    struct YonderColors {
        
        // MARK: - Background
        
        let backgroundMaxDepth = Color("Assets#161B23")
        let backgroundMidDepth = Color("Assets#1C222C")
        let backgroundMinDepth = Color("Assets#272E39")
        
        // MARK: - Text
        
        let textMaxContrast = Color("Assets#FFFFFF")
        let textMidContrast = Color("Assets#BFC0C4")
        let textMinContrast = Color("Assets#93979C")
        
        // MARK: - Other
        
        let highlight = Color("Assets#1988E9")
    }
    
}
