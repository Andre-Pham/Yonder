//
//  EmbeddedInspectBorder.swift
//  yonder
//
//  Created by Andre Pham on 3/3/2023.
//

import Foundation
import SwiftUI

struct EmbeddedInspectBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.top, 16)
            .padding(.bottom, 24)
            .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
    }
}
extension View {
    func embeddedInspectBorder() -> some View {
        modifier(EmbeddedInspectBorder())
    }
}
