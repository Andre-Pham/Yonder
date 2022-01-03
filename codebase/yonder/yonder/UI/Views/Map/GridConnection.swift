//
//  GridConnection.swift
//  yonder
//
//  Created by Andre Pham on 3/1/2022.
//

import Foundation
import SwiftUI

struct GridConnection: View {
    // Parameters
    let down: Int
    let downAcross: Int // Use -/+ to determine left/right
    let spacing: CGFloat
    let horizontalOffset: CGFloat
    
    var downVGridConverted: CGFloat {
        // Parameter 'down', but adjusted to account for the fact that 'downAcross' causes a difference in hexagon y coordinates
        return CGFloat(abs(down) - abs(downAcross))
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                if downVGridConverted > 0 {
                    Line(start: getStart(geometry: geo), end: getDownEnd(geometry: geo), horizontalOffset: horizontalOffset)
                        .stroke(.red, lineWidth: 10)
                        .reverseScroll()
                }
                if downAcross != 0 {
                    Line(start: getStart(geometry: geo), end: getDownAcrossEnd(geometry: geo), verticalOffset: downVGridConverted*(geo.size.height*2 + spacing*2), horizontalOffset: horizontalOffset)
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
        var (endX, endY) = getStart(geometry: geometry)
        
        for _ in 0..<Int((downVGridConverted/2).rounded(.down)) {
            endY += geometry.size.height*2 + spacing*2
        }
        
        return (endX, endY)
    }
    
    func getDownAcrossEnd(geometry: GeometryProxy) -> (CGFloat, CGFloat) {
        var (endX, endY) = getStart(geometry: geometry)
        
        for _ in 0..<abs(downAcross) {
            endX += (geometry.size.width/2 + spacing/2)*CGFloat(downAcross.signum())
            endY += geometry.size.height + spacing
        }
        
        return (endX, endY)
    }
}
