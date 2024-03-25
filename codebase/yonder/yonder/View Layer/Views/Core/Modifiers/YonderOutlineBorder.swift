//
//  YonderOutlineBorder.swift
//  yonder
//
//  Created by Andre Pham on 6/5/2022.
//

import SwiftUI

struct YonderOutlineBorder: ViewModifier {
    var verticalPadding: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, self.verticalPadding)
            .padding(.horizontal, YonderCoreGraphics.padding)
            .background(YonderColors.backgroundMaxDepth)
            .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
    }
}
extension View {
    func yonderOutlineBorder(verticalPadding: CGFloat = YonderCoreGraphics.textVerticalPadding) -> some View {
        modifier(YonderOutlineBorder(verticalPadding: verticalPadding))
    }
}
