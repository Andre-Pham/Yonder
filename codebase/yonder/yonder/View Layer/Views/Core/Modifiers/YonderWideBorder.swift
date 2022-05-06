//
//  YonderWideBorder.swift
//  yonder
//
//  Created by Andre Pham on 6/5/2022.
//

import SwiftUI

struct YonderWideBorder: ViewModifier {
    var verticalPadding: CGFloat = 13
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding(.vertical, self.verticalPadding)
            .padding(.horizontal, YonderCoreGraphics.padding)
            .background(Color.Yonder.backgroundMaxDepth)
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}
extension View {
    func yonderWideBorder(verticalPadding: CGFloat = 13) -> some View {
        modifier(YonderWideBorder(verticalPadding: verticalPadding))
    }
}
