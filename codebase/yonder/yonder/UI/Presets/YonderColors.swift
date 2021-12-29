//
//  YonderUIColors.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

extension Color {
    
    static let Yonder = Color.YonderColors()
    
    struct YonderColors {
        
        // MARK: - Background
        
        let backgroundMaxDepth = Color("Assets#000000")
        //let backgroundMidDepth = Color("Assets#000000")
        //let backgroundMinDepth = Color("Assets#000000")
        
        // MARK: - Text
        
        let textMaxContrast = Color("Assets#FFFFFF")
        //let textMidContrast = Color("Assets#BFC0C4")
        //let textMinContrast = Color("Assets#93979C")
        
        // MARK: - Other
        
        //let highlight = Color("Assets#1988E9")
        let border = Color("Assets#FFFFFF")
    }
    
}
