//
//  Line.swift
//  yonder
//
//  Created by Andre Pham on 2/1/2022.
//

import Foundation
import SwiftUI

struct Line: Shape {
    let start: (CGFloat, CGFloat)
    let end: (CGFloat, CGFloat)
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: start.0, y: start.1))
        path.addLine(to: CGPoint(x: end.0, y: end.1))
        return path
    }
}
