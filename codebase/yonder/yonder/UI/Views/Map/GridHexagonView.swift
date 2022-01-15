//
//  GridHexagonView.swift
//  yonder
//
//  Created by Andre Pham on 16/1/2022.
//

import SwiftUI

struct GridHexagonView: View {
    let hexagonFrameWidth: CGFloat
    let hexagonFrameHeight: CGFloat
    let spacing: CGFloat
    let horizontalOffset: CGFloat
    var scale: CGFloat = 1
    var strokeStyle: GridHexagonViewStrokeStyle = .none
    var strokeColor: Color = Color.Yonder.border
    var fill: Bool = false
    var fillColor: Color = Color.Yonder.backgroundMaxDepth
    
    var body: some View {
        Hexagon()
            .gridHexagonStyle(
                strokeStyle: self.strokeStyle,
                strokeColor: self.strokeColor,
                fill: self.fill,
                fillColor: self.fillColor)
            .gridHexagonFrame(
                hexagonFrameWidth: self.hexagonFrameWidth,
                hexagonFrameHeight: self.hexagonFrameHeight,
                spacing: self.spacing,
                horizontalOffset: self.horizontalOffset,
                scale: self.scale)
            .reverseScroll()
    }
}

enum GridHexagonViewStrokeStyle {
    case stroke
    case strokeBorder
    case none
}

extension InsettableShape {
    func gridHexagonStyle(strokeStyle: GridHexagonViewStrokeStyle, strokeColor: Color, fill: Bool, fillColor: Color) -> some View {
        switch strokeStyle {
        case .stroke:
            if fill {
                return AnyView(ZStack {
                    self.fill(fillColor)
                    
                    self.stroke(strokeColor, lineWidth: YonderCoreGraphics.borderWidth)
                })
            }
            else {
                return AnyView(self.stroke(strokeColor, lineWidth: YonderCoreGraphics.borderWidth))
            }
        case .strokeBorder:
            if fill {
                return AnyView(self
                                .strokeBorder(strokeColor, lineWidth: YonderCoreGraphics.borderWidth)
                                .background(Hexagon().foregroundColor(fillColor)))
            }
            else {
                return AnyView(self.strokeBorder(strokeColor, lineWidth: YonderCoreGraphics.borderWidth))
            }
        case .none:
            if fill {
                return AnyView(self.fill(fillColor))
            }
            else {
                return AnyView(self)
            }
        }
    }
}

struct GridHexagonFrame: ViewModifier {
    let hexagonFrameWidth: CGFloat
    let hexagonFrameHeight: CGFloat
    let spacing: CGFloat
    let horizontalOffset: CGFloat
    let scale: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: self.scale*self.hexagonFrameWidth, height: self.scale*self.hexagonFrameHeight/2)
            .offset(x: horizontalOffset)
            .frame(width: (self.hexagonFrameHeight*MathConstants.hexagonWidthToHeight)/2 + self.spacing, height: self.hexagonFrameHeight*0.216) // 0.216 was found from trial and error so don't think too hard about it
    }
}
extension View {
    func gridHexagonFrame(hexagonFrameWidth: CGFloat, hexagonFrameHeight: CGFloat, spacing: CGFloat, horizontalOffset: CGFloat, scale: CGFloat = 1) -> some View {
        modifier(GridHexagonFrame(hexagonFrameWidth: hexagonFrameWidth, hexagonFrameHeight: hexagonFrameHeight, spacing: spacing, horizontalOffset: horizontalOffset, scale: scale))
    }
}
