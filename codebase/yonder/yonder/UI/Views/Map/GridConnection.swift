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
    let geoWidth: CGFloat
    let geoHeight: CGFloat
    let spacing: CGFloat
    let horizontalOffset: CGFloat
    
    var downVGridConverted: CGFloat {
        // Parameter 'down', but adjusted to account for the fact that 'downAcross' causes a difference in hexagon y coordinates
        return CGFloat(abs(down) - abs(downAcross))
    }
    
    var body: some View {
        ZStack {
            if downVGridConverted > 0 {
                Line(start: getStart(), end: getDownEnd(), horizontalOffset: horizontalOffset)
                    .stroke(.red, lineWidth: 10)
                    .reverseScroll()
            }
            if downAcross != 0 {
                Line(start: getStart(), end: getDownAcrossEnd(), verticalOffset: downVGridConverted*(geoHeight*2 + spacing*2), horizontalOffset: horizontalOffset)
                    .stroke(.red, lineWidth: 10)
                    .reverseScroll()
            }
        }
    }
    
    func getStart() -> (CGFloat, CGFloat) {
        let startX = geoWidth/2
        let startY = geoHeight/2
        
        return (startX, startY)
    }
    
    func getDownEnd() -> (CGFloat, CGFloat) {
        var (endX, endY) = getStart()
        
        for _ in 0..<Int((downVGridConverted/2).rounded(.down)) {
            endY += geoHeight*2 + spacing*2
        }
        
        return (endX, endY)
    }
    
    func getDownAcrossEnd() -> (CGFloat, CGFloat) {
        var (endX, endY) = getStart()
        
        for _ in 0..<abs(downAcross) {
            endX += (geoWidth/2 + spacing/2)*CGFloat(downAcross.signum())
            endY += geoHeight + spacing
        }
        
        return (endX, endY)
    }
}
