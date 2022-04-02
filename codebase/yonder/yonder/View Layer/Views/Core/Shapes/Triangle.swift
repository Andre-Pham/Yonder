//
//  Triangle.swift
//  yonder
//
//  Created by Andre Pham on 26/1/2022.
//

import SwiftUI

struct Triangle: InsettableShape {
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let insetYDistance = 2*sin(30*MathConstants.degreesToRadians)*self.insetAmount
        let insetXDistance = 2*cos(30*MathConstants.degreesToRadians)*self.insetAmount
        
        let point1 = CGPoint(x: insetXDistance, y: insetYDistance)
        let point2 = CGPoint(x: rect.width - insetXDistance, y: insetYDistance)
        let point3 = CGPoint(x: rect.width/2, y: rect.width/2*(3.squareRoot()) - self.insetAmount/sin(30*MathConstants.degreesToRadians))
        var path = Path()
        path.move(to: point1)
        path.addLine(to: point2)
        path.addLine(to: point3)
        path.closeSubpath()
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var triangle = self
        triangle.insetAmount += amount
        return triangle
    }
}

struct Triangle_Previews: PreviewProvider {
    static var previews: some View {
        Triangle()
            .strokeBorder(lineWidth: 50)
    }
}
