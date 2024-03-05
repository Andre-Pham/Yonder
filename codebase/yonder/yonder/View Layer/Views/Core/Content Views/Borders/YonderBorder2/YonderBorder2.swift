//
//  YonderBorder2.swift
//  yonder
//
//  Created by Andre Pham on 28/2/2024.
//

import SwiftUI

struct YonderBorder2<Content: View>: View {
    
    private let content: () -> Content
    
    init(
        @ViewBuilder builder: @escaping () -> Content
    ) {
        self.content = builder
    }
    
    var body: some View {
        SliceInsetBorder8(
            scale: 0.75,
            imageTop: YonderBorder2Presets.topBorder,
            imageLeft: YonderBorder2Presets.leftBorder,
            imageRight: YonderBorder2Presets.rightBorder,
            imageBottom: YonderBorder2Presets.bottomBorder,
            imageTopLeft: YonderBorder2Presets.topLeftCorner,
            imageTopRight: YonderBorder2Presets.topRightCorner,
            imageBottomLeft: YonderBorder2Presets.bottomLeftCorner,
            imageBottomRight: YonderBorder2Presets.bottomRightCorner,
            topLeftInsetDim: YonderBorder2Presets.topLeftInset,
            topRightInsetDim: YonderBorder2Presets.topRightInset,
            bottomLeftInsetDim: YonderBorder2Presets.bottomLeftInset,
            bottomRightInsetDim: YonderBorder2Presets.bottomRightInset
        ) {
            content()
                .background(YonderBorder2Presets.fillColor)
        }
    }
}

#Preview {
    YonderBorder2 {
        Rectangle()
            .fill(.clear)
            .frame(width: 160, height: 100)
    }
}
