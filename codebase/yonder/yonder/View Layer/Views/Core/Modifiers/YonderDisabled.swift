//
//  YonderDisabled.swift
//  yonder
//
//  Created by Andre Pham on 18/4/2022.
//

import Foundation
import SwiftUI

struct YonderDisabled: ViewModifier {
    let isDisabled: Bool
    
    func body(content: Content) -> some View {
        content
            .disabled(self.isDisabled)
            .opacity(self.isDisabled ? YonderCoreGraphics.disabledButtonOpacity : 1)
    }
}
extension View {
    func disabledWhen(_ isDisabled: Bool) -> some View {
        modifier(YonderDisabled(isDisabled: isDisabled))
    }
}
