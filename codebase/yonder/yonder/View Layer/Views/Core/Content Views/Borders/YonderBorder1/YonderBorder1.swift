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
            imageTop: YonderBorder1Presets.border1Top,
            imageLeft: YonderBorder1Presets.border1Left,
            imageRight: YonderBorder1Presets.border1Right,
            imageBottom: YonderBorder1Presets.border1Bottom,
            imageTopLeft: YonderBorder1Presets.border1TopLeft,
            imageTopRight: YonderBorder1Presets.border1TopRight,
            imageBottomLeft: YonderBorder1Presets.border1BottomLeft,
            imageBottomRight: YonderBorder1Presets.border1BottomRight,
            topLeftInsetDim: YonderBorder1Presets.border1TopLeftInset,
            topRightInsetDim: YonderBorder1Presets.border1TopRightInset,
            bottomLeftInsetDim: YonderBorder1Presets.border1BottomLeftInset,
            bottomRightInsetDim: YonderBorder1Presets.border1BottomRightInset
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
