//
//  YonderFonts.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

enum YonderFonts {
    
    static func main(size: CGFloat = 18, scaling: Font.TextStyle = .body) -> Font {
        return Font.custom("Mx437_DOS-V_TWN16", size: size, relativeTo: scaling)
    }
    
}
