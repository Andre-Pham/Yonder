//
//  RepeatColorAnimation.swift
//  yonder
//
//  Created by Andre Pham on 27/1/2022.
//

import Foundation
import SwiftUI

struct RepeatColorAnimation: ViewModifier {
    @Binding var color: Color
    let transitionColor: Color
    let duration: Double
    let active: Bool
    
    func body(content: Content) -> some View {
        if self.active {
            content
                .animation(Animation.easeInOut(duration: self.duration).repeatForever(autoreverses: true), value: self.color)
                .onAppear {
                    self.color = self.transitionColor
                }
        }
        else {
            content
        }
    }
}
extension View {
    func repeatColorAnimation(color: Binding<Color>, transitionColor: Color, duration: Double = 1, active: Bool = true) -> some View {
        modifier(RepeatColorAnimation(color: color, transitionColor: transitionColor, duration: duration, active: active))
    }
}
