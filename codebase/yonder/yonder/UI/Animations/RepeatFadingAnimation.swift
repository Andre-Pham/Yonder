//
//  RepeatFadingAnimation.swift
//  yonder
//
//  Created by Andre Pham on 26/1/2022.
//

import Foundation
import SwiftUI

struct RepeatFadingAnimation: ViewModifier {
    @State private var opacity: Double = 1
    let duration: Double
    
    func body(content: Content) -> some View {
        content
            .opacity(self.opacity)
            .animation(Animation.easeInOut(duration: self.duration).repeatForever(autoreverses: true), value: self.opacity)
            .onAppear {
                self.opacity = 0
            }
    }
}
extension View {
    func repeatFadingAnimation(duration: Double = 1) -> some View {
        modifier(RepeatFadingAnimation(duration: duration))
    }
}
