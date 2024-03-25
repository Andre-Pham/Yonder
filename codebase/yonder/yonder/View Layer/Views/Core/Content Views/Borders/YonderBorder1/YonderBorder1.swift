//
//  YonderBorder1.swift
//  yonder
//
//  Created by Andre Pham on 18/1/2024.
//

import SwiftUI

struct YonderBorder1<Content: View>: View {
    
    private let content: () -> Content
    
    init(
        @ViewBuilder builder: @escaping () -> Content
    ) {
        self.content = builder
    }
    
    var body: some View {
        SliceInsetBorder8(
            scale: 0.75,
            imageTop: YonderBorder1Presets.topBorder,
            imageLeft: YonderBorder1Presets.leftBorder,
            imageRight: YonderBorder1Presets.rightBorder,
            imageBottom: YonderBorder1Presets.bottomBorder,
            imageTopLeft: YonderBorder1Presets.topLeftCorner,
            imageTopRight: YonderBorder1Presets.topRightCorner,
            imageBottomLeft: YonderBorder1Presets.bottomLeftCorner,
            imageBottomRight: YonderBorder1Presets.bottomRightCorner,
            topLeftInsetDim: YonderBorder1Presets.topLeftInset,
            topRightInsetDim: YonderBorder1Presets.topRightInset,
            bottomLeftInsetDim: YonderBorder1Presets.bottomLeftInset,
            bottomRightInsetDim: YonderBorder1Presets.bottomRightInset
        ) {
            content()
        }
    }
}

#Preview {
    YonderBorder1 {
        Rectangle()
            .fill(.blue)
            .frame(width: 160, height: 100)
    }
}
