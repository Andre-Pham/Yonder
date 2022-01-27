//
//  GridHexagonView.swift
//  yonder
//
//  Created by Andre Pham on 16/1/2022.
//

import SwiftUI

struct GridHexagonView: View {
    @EnvironmentObject var gridDimensions: GridDimensions
    
    let hexagonIndex: Int
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
                hexagonIndex: self.hexagonIndex,
                scale: self.scale)
            .reverseScroll()
            .environmentObject(self.gridDimensions)
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
                    
                    self.stroke(strokeColor, lineWidth: YonderCoreGraphics.mapGridLineWidth)
                })
            }
            else {
                return AnyView(self.stroke(strokeColor, lineWidth: YonderCoreGraphics.mapGridLineWidth))
            }
        case .strokeBorder:
            if fill {
                return AnyView(self
                                .strokeBorder(strokeColor, lineWidth: YonderCoreGraphics.mapGridLineWidth)
                                .background(Hexagon().foregroundColor(fillColor)))
            }
            else {
                return AnyView(self.strokeBorder(strokeColor, lineWidth: YonderCoreGraphics.mapGridLineWidth))
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
    @EnvironmentObject var gridDimensions: GridDimensions
    let hexagonIndex: Int
    let scale: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(
                width: self.scale*self.gridDimensions.hexagonFrameWidth,
                height: self.scale*self.gridDimensions.hexagonFrameHeight/2)
            .offset(x: self.gridDimensions.getHorizontalOffset(hexagonIndex: self.hexagonIndex))
            .frame(
                width: self.gridDimensions.getGridHexagonFrameWidth(),
                height: self.gridDimensions.getGridHexagonFrameHeight())
    }
}
extension View {
    func gridHexagonFrame(hexagonIndex: Int, scale: CGFloat = 1) -> some View {
        modifier(GridHexagonFrame(hexagonIndex: hexagonIndex, scale: scale))
    }
}
