//
//  Line.swift
//  yonder
//
//  Created by Andre Pham on 2/1/2022.
//

import Foundation
import SwiftUI

struct Line: Shape {
    // Parameters
    let start: (CGFloat, CGFloat)
    let end: (CGFloat, CGFloat)
    
    // Optional Parameters
    var verticalOffset: CGFloat = 0
    var horizontalOffset: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: start.0 + horizontalOffset, y: start.1 + verticalOffset))
        path.addLine(to: CGPoint(x: end.0 + horizontalOffset, y: end.1 + verticalOffset))
        return path
    }
}
