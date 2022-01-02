//
//  Hexagon.swift
//  yonder
//
//  Created by Andre Pham on 2/1/2022.
//

import Foundation
import SwiftUI

// https://swiftui-lab.com/impossible-grids/
struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        let sidesCount = 6
        let diagonalRadius = Double(min(rect.width, rect.height))/2.0
        let rectCentre = CGPoint(x: rect.width/2.0, y: rect.height/2.0)
        var path = Path()
        
        for sideIndex in 0..<sidesCount {
            let angle = Double(sideIndex)*360.0/Double(sidesCount)*MathConstants.degreesToRadians
            let point = CGPoint(
                x: rectCentre.x + CGFloat(cos(angle)*diagonalRadius),
                y: rectCentre.y + CGFloat(sin(angle)*diagonalRadius))
            
            if sideIndex == 0 {
                path.move(to: point)
            }
            else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        
        return path
    }
}
