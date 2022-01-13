//
//  GridConnectionView.swift
//  yonder
//
//  Created by Andre Pham on 3/1/2022.
//

import Foundation
import SwiftUI

struct GridConnectionView: View {
    let down: Int
    let downAcross: Int // Use -/+ to determine left/right
    let spacing: CGFloat
    let horizontalOffset: CGFloat
    
    var downVGridConverted: CGFloat {
        // Parameter 'down', but adjusted to account for the fact that 'downAcross' causes a difference in hexagon y coordinates
        return CGFloat(abs(self.down) - abs(self.downAcross))
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if self.downVGridConverted > 0 {
                    Line(start: self.getStart(geometry: geo), end: self.getDownEnd(geometry: geo), horizontalOffset: self.horizontalOffset)
                        .stroke(.red, lineWidth: 10)
                        .reverseScroll()
                }
                if self.downAcross != 0 {
                    Line(start: self.getStart(geometry: geo), end: self.getDownAcrossEnd(geometry: geo), verticalOffset: self.downVGridConverted*(geo.size.height*2 + self.spacing*2), horizontalOffset: self.horizontalOffset)
                        .stroke(.red, lineWidth: 10)
                        .reverseScroll()
                }
            }
        }
    }
    
    func getStart(geometry: GeometryProxy) -> (CGFloat, CGFloat) {
        let startX = geometry.size.width/2
        let startY = geometry.size.height/2
        
        return (startX, startY)
    }
    
    func getDownEnd(geometry: GeometryProxy) -> (CGFloat, CGFloat) {
        var (endX, endY) = self.getStart(geometry: geometry)
        
        for _ in 0..<Int((self.downVGridConverted/2).rounded(.down)) {
            endY += geometry.size.height*2 + self.spacing*2
        }
        
        return (endX, endY)
    }
    
    func getDownAcrossEnd(geometry: GeometryProxy) -> (CGFloat, CGFloat) {
        var (endX, endY) = self.getStart(geometry: geometry)
        
        for _ in 0..<abs(self.downAcross) {
            endX += (geometry.size.width/2 + self.spacing/2)*CGFloat(self.downAcross.signum())
            endY += geometry.size.height + self.spacing
        }
        
        return (endX, endY)
    }
}
