//
//  ReverseScroll.swift
//  yonder
//
//  Created by Andre Pham on 2/1/2022.
//

import Foundation
import SwiftUI

struct ReverseScroll: ViewModifier {
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
    }
}
extension View {
    func reverseScroll() -> some View {
        modifier(ReverseScroll())
    }
}
