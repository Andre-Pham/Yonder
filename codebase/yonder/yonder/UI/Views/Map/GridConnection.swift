//
//  GridConnection.swift
//  yonder
//
//  Created by Andre Pham on 3/1/2022.
//

import Foundation
import SwiftUI

struct GridConnection: View {
    let down: Int
    let downAcross: Int // Use -/+ to determine left/right
    
    let geoWidth: CGFloat
    let geoHeight: CGFloat
    let spacing: CGFloat
    let offset: CGFloat
    
    var body: some View {
        ZStack {
            if down - abs(downAcross) > 0 {
                Line(start: getStart(), end: getDownEnd())
                    .stroke(.red, lineWidth: 10)
                    .reverseScroll()
            }
            if downAcross != 0 {
                let offset = CGFloat(down - abs(downAcross))*(geoHeight*2 + spacing*2)
                Line(start: getStart(verticalOffset: offset), end: getDownAcrossEnd(verticalOffset: offset))
                    .stroke(.red, lineWidth: 10)
                    .reverseScroll()
            }
        }
    }
    
    func getStart(verticalOffset: CGFloat = 0) -> (CGFloat, CGFloat) {
        let startX = geoWidth/2 + offset
        let startY = geoHeight/2 + verticalOffset
        
        return (startX, startY)
    }
    
    func getDownEnd() -> (CGFloat, CGFloat) {
        let endX = geoWidth/2 + offset
        var endY = geoHeight/2
        
        for _ in 0..<Int((Double(down - abs(downAcross))/2).rounded(.down)) {
            endY += geoHeight*2 + spacing*2
        }
        
        return (endX, endY)
    }
    
    func getDownAcrossEnd(verticalOffset: CGFloat = 0) -> (CGFloat, CGFloat) {
        var endX = geoWidth/2 + offset
        var endY = geoHeight/2 + verticalOffset
        
        for _ in 0..<abs(downAcross) {
            endX += (geoWidth/2 + spacing/2)*CGFloat(downAcross.signum())
            endY += geoHeight + spacing
        }
        
        return (endX, endY)
    }
}
