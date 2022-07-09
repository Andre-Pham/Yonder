//
//  YonderGridOption.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

/// A square button that adapts its size to match its sides to `1/YonderOptionsGrid.columnCount` of the provided geometry's width, subtract padding.
/// Intended to be used with `YonderOptionsGrid`.
struct YonderGridOption: View {
    let title: String
    let geometry: GeometryProxy
    let image: Image
    let columnCount = CGFloat(YonderGridConstants.optionsGridColumnCount)
    var width: CGFloat {
        geometry.size.width/columnCount - YonderCoreGraphics.padding*(columnCount+1)/columnCount
    }
    var height: CGFloat {
        geometry.size.width/columnCount - YonderCoreGraphics.padding*2
    }
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                YonderIcon(image: self.image, sideLength: .large)
                
                YonderText(text: self.title, size: .optionBody, multilineTextAlignment: .center)
            }
            .padding(.horizontal)
            .frame(width: self.width, height: self.height)
            .border(YonderColors.border, width: YonderCoreGraphics.borderWidth)
        }
    }
}
