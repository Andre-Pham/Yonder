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
            scale: 0.5,
            imageTop: YonderImages.border1Top,
            imageLeft: YonderImages.border1Left,
            imageRight: YonderImages.border1Right,
            imageBottom: YonderImages.border1Bottom,
            imageTopLeft: YonderImages.border1TopLeft,
            imageTopRight: YonderImages.border1TopRight,
            imageBottomLeft: YonderImages.border1BottomLeft,
            imageBottomRight: YonderImages.border1BottomRight,
            topLeftInsetDim: YonderImages.border1TopLeftInset,
            topRightInsetDim: YonderImages.border1TopRightInset,
            bottomLeftInsetDim: YonderImages.border1BottomLeftInset,
            bottomRightInsetDim: YonderImages.border1BottomRightInset
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
