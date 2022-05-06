//
//  YonderBorder.swift
//  yonder
//
//  Created by Andre Pham on 6/5/2022.
//

import SwiftUI

struct YonderBorder: ViewModifier {
    var verticalPadding: CGFloat = 13
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, self.verticalPadding)
            .padding(.horizontal, YonderCoreGraphics.padding)
            .background(Color.Yonder.backgroundMaxDepth)
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}
extension View {
    func yonderBorder(verticalPadding: CGFloat = 13) -> some View {
        modifier(YonderBorder(verticalPadding: verticalPadding))
    }
}