//
//  RepeatFadingAnimation.swift
//  yonder
//
//  Created by Andre Pham on 26/1/2022.
//

import Foundation
import SwiftUI

struct RepeatFadingAnimation: ViewModifier {
    @State var opacity: Double
    let duration: Double
    let bounds: (Double, Double)
    let active: Bool
    
    init(duration: Double, bounds: (Double, Double), active: Bool) {
        self.duration = duration
        self.bounds = bounds
        self.active = active
        self.opacity = bounds.1
    }
    
    func body(content: Content) -> some View {
        if self.active {
            content
                .opacity(self.opacity)
                .animation(Animation.easeInOut(duration: self.duration).repeatForever(autoreverses: true), value: self.opacity)
                .onAppear {
                    self.opacity = bounds.0
                }
        }
        else {
            content
        }
    }
}
extension View {
    func repeatFadingAnimation(duration: Double = 1, bounds: (Double, Double) = (0, 1), active: Bool = true) -> some View {
        modifier(RepeatFadingAnimation(duration: duration, bounds: bounds, active: active))
    }
}
