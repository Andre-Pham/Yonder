//
//  YonderBorder13.swift
//  yonder
//
//  Created by Andre Pham on 25/3/2024.
//

import Foundation
import SwiftUI

struct YonderBorder13<Content: View>: View {
    
    private let content: () -> Content
    
    init(
        @ViewBuilder builder: @escaping () -> Content
    ) {
        self.content = builder
    }
    
    var body: some View {
        SliceInsetBorder8(
            scale: 0.75,
            imageTop: YonderBorder13Presets.topBorder,
            imageLeft: YonderBorder13Presets.leftBorder,
            imageRight: YonderBorder13Presets.rightBorder,
            imageBottom: YonderBorder13Presets.bottomBorder,
            imageTopLeft: YonderBorder13Presets.topLeftCorner,
            imageTopRight: YonderBorder13Presets.topRightCorner,
            imageBottomLeft: YonderBorder13Presets.bottomLeftCorner,
            imageBottomRight: YonderBorder13Presets.bottomRightCorner,
            topLeftInsetDim: YonderBorder13Presets.topLeftInset,
            topRightInsetDim: YonderBorder13Presets.topRightInset,
            bottomLeftInsetDim: YonderBorder13Presets.bottomLeftInset,
            bottomRightInsetDim: YonderBorder13Presets.bottomRightInset
        ) {
            content()
                .padding(YonderBorder3Presets.outlineThickness)
                .border(
                    YonderBorder3Presets.outlineColor,
                    width: YonderBorder3Presets.outlineThickness
                )
                .background(YonderBorder13Presets.fillColor)
        }
    }
}

#Preview {
    YonderBorder13 {
        Rectangle()
            .fill(.clear)
            .frame(width: 160, height: 100)
            .overlay {
                YonderText(text: "Hello World", size: .buttonBody)
            }
    }
}
