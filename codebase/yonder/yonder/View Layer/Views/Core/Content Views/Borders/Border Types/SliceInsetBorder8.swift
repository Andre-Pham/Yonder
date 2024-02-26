//
//  SliceInsetBorder8.swift
//  yonder
//
//  Created by Andre Pham on 18/1/2024.
//

import SwiftUI

struct SliceInsetBorder8<Content: View>: View {
    
    @State private var contentSize: CGSize
    
    private let scale: Double
    private let imageTop: YonderImage
    private let imageLeft: YonderImage
    private let imageRight: YonderImage
    private let imageBottom: YonderImage
    private let imageTopLeft: YonderImage
    private let imageTopRight: YonderImage
    private let imageBottomLeft: YonderImage
    private let imageBottomRight: YonderImage
    private let topLeftInsetDim: CGSize
    private let topRightInsetDim: CGSize
    private let bottomLeftInsetDim: CGSize
    private let bottomRightInsetDim: CGSize
    private let content: () -> Content
    
    init(
        scale: Double = 1.0,
        imageTop: YonderImage,
        imageLeft: YonderImage,
        imageRight: YonderImage,
        imageBottom: YonderImage,
        imageTopLeft: YonderImage,
        imageTopRight: YonderImage,
        imageBottomLeft: YonderImage,
        imageBottomRight: YonderImage,
        topLeftInsetDim: YonderImage? = nil,
        topRightInsetDim: YonderImage? = nil,
        bottomLeftInsetDim: YonderImage? = nil,
        bottomRightInsetDim: YonderImage? = nil,
        @ViewBuilder builder: @escaping () -> Content
    ) {
        self.scale = scale
        self.imageTop = imageTop
        self.imageLeft = imageLeft
        self.imageRight = imageRight
        self.imageBottom = imageBottom
        self.imageTopLeft = imageTopLeft
        self.imageTopRight = imageTopRight
        self.imageBottomLeft = imageBottomLeft
        self.imageBottomRight = imageBottomRight
        self.topLeftInsetDim = CGSize(
            width: (topLeftInsetDim?.width ?? 0.0)*self.scale,
            height: (topLeftInsetDim?.height ?? 0.0)*self.scale
        )
        self.topRightInsetDim = CGSize(
            width: (topRightInsetDim?.width ?? 0.0)*self.scale,
            height: (topRightInsetDim?.height ?? 0.0)*self.scale
        )
        self.bottomLeftInsetDim = CGSize(
            width: (bottomLeftInsetDim?.width ?? 0.0)*self.scale,
            height: (bottomLeftInsetDim?.height ?? 0.0)*self.scale
        )
        self.bottomRightInsetDim = CGSize(
            width: (bottomRightInsetDim?.width ?? 0.0)*self.scale,
            height: (bottomRightInsetDim?.height ?? 0.0)*self.scale
        )
        self.content = builder
        self.contentSize = CGSize()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Top row
            HStack(alignment: .bottom, spacing: 0) {
                BorderSlice(
                    source: self.imageTopLeft,
                    scale: self.scale
                )
                .offset(y: self.topLeftInsetDim.height)
                
                BorderSlice(
                    source: self.imageTop,
                    scale: self.scale,
                    widthOverride: (
                        self.contentSize.width 
                        - self.topLeftInsetDim.width
                        - self.topRightInsetDim.width
                    )
                )
                
                BorderSlice(
                    source: self.imageTopRight,
                    scale: self.scale
                )
                .offset(y: self.topRightInsetDim.height)
            }
            .zIndex(1)
            .frame(height: self.imageTop.height*self.scale, alignment: .bottom)
            
            // Middle row
            HStack(spacing: 0) {
                BorderSlice(
                    source: self.imageLeft,
                    scale: self.scale,
                    heightOverride: (
                        self.contentSize.height
                        - self.topLeftInsetDim.height
                        - self.bottomLeftInsetDim.height
                    )
                )
                
                content()
                    .overlay {
                        GeometryReader { geo in
                            Color.clear
                                .onAppear {
                                    self.contentSize = geo.size
                                }
                        }
                    }
                
                BorderSlice(
                    source: self.imageRight,
                    scale: self.scale,
                    heightOverride: (
                        self.contentSize.height
                        - self.topRightInsetDim.height
                        - self.topRightInsetDim.height
                    )
                )
            }
            
            // Bottom row
            HStack(alignment: .top, spacing: 0) {
                BorderSlice(
                    source: self.imageBottomLeft,
                    scale: self.scale
                )
                .offset(y: -self.bottomLeftInsetDim.height)
                
                BorderSlice(
                    source: self.imageBottom,
                    scale: self.scale,
                    widthOverride: (
                        self.contentSize.width
                        - self.bottomLeftInsetDim.width
                        - self.bottomRightInsetDim.width
                    )
                )
                
                BorderSlice(
                    source: self.imageBottomRight,
                    scale: self.scale
                )
                .offset(y: -self.bottomRightInsetDim.height)
            }
            .zIndex(1)
            .frame(height: self.imageBottom.height*self.scale, alignment: .top)
        }
    }
}

#Preview {
    SliceInsetBorder8(
        scale: 1.0,
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
        Rectangle()
            .fill(.blue)
            .frame(width: 160, height: 100)
    }
}
