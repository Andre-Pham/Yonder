//
//  YonderBorder12.swift
//  yonder
//
//  Created by Andre Pham on 25/3/2024.
//

import Foundation
import SwiftUI

struct YonderBorder12<Content: View>: View {
    
    private let content: () -> Content
    
    init(
        @ViewBuilder builder: @escaping () -> Content
    ) {
        self.content = builder
    }
    
    var body: some View {
        SliceInsetBorder8(
            scale: 0.75,
            imageTop: YonderBorder12Presets.topBorder,
            imageLeft: YonderBorder12Presets.leftBorder,
            imageRight: YonderBorder12Presets.rightBorder,
            imageBottom: YonderBorder12Presets.bottomBorder,
            imageTopLeft: YonderBorder12Presets.topLeftCorner,
            imageTopRight: YonderBorder12Presets.topRightCorner,
            imageBottomLeft: YonderBorder12Presets.bottomLeftCorner,
            imageBottomRight: YonderBorder12Presets.bottomRightCorner,
            topLeftInsetDim: YonderBorder12Presets.topLeftInset,
            topRightInsetDim: YonderBorder12Presets.topRightInset,
            bottomLeftInsetDim: YonderBorder12Presets.bottomLeftInset,
            bottomRightInsetDim: YonderBorder12Presets.bottomRightInset
        ) {
            content()
                .background(YonderBorder12Presets.fillColor)
        }
    }
}

#Preview {
    YonderBorder12 {
        Rectangle()
            .fill(.clear)
            .frame(width: 160, height: 100)
            .overlay {
                YonderText(text: "Hello World", size: .buttonBody)
            }
    }
}
