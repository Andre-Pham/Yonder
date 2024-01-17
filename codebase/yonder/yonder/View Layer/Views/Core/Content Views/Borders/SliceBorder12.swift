//
//  SliceBorder12.swift
//  yonder
//
//  Created by Andre Pham on 18/1/2024.
//

import SwiftUI

struct SliceBorder12<Content: View>: View {
    
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
    private let imageInnerTopLeft: YonderImage
    private let imageInnerTopRight: YonderImage
    private let imageInnerBottomLeft: YonderImage
    private let imageInnerBottomRight: YonderImage
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
        imageInnerTopLeft: YonderImage,
        imageInnerTopRight: YonderImage,
        imageInnerBottomLeft: YonderImage,
        imageInnerBottomRight: YonderImage,
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
        self.imageInnerTopLeft = imageInnerTopLeft
        self.imageInnerTopRight = imageInnerTopRight
        self.imageInnerBottomLeft = imageInnerBottomLeft
        self.imageInnerBottomRight = imageInnerBottomRight
        self.content = builder
        self.contentSize = CGSize()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Top row
            HStack(spacing: 0) {
                BorderSlice(
                    source: self.imageTopLeft,
                    scale: self.scale
                )
                
                BorderSlice(
                    source: self.imageTop,
                    scale: self.scale,
                    widthOverride: self.contentSize.width
                )
                
                BorderSlice(
                    source: self.imageTopRight,
                    scale: self.scale
                )
            }
            
            // Middle row
            HStack(spacing: 0) {
                BorderSlice(
                    source: self.imageLeft,
                    scale: self.scale,
                    heightOverride: self.contentSize.height
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
                    .overlay {
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                BorderSlice(
                                    source: self.imageInnerTopLeft,
                                    scale: self.scale
                                )
                                
                                Spacer()
                                
                                BorderSlice(
                                    source: self.imageInnerTopRight,
                                    scale: self.scale
                                )
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 0) {
                                BorderSlice(
                                    source: self.imageInnerBottomLeft,
                                    scale: self.scale
                                )
                                
                                Spacer()
                                
                                BorderSlice(
                                    source: self.imageInnerBottomRight,
                                    scale: self.scale
                                )
                            }
                        }
                    }
                
                BorderSlice(
                    source: self.imageRight,
                    scale: self.scale,
                    heightOverride: self.contentSize.height
                )
            }
            
            // Bottom row
            HStack(spacing: 0) {
                BorderSlice(
                    source: self.imageBottomLeft,
                    scale: self.scale
                )
                
                BorderSlice(
                    source: self.imageBottom,
                    scale: self.scale,
                    widthOverride: self.contentSize.width
                )
                
                BorderSlice(
                    source: self.imageBottomRight,
                    scale: self.scale
                )
            }
        }
    }
}

struct SliceBorder12_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            SliceBorder12(
                scale: 0.15,
                imageTop: YonderImages.bruteIcon,
                imageLeft: YonderImages.bruteIcon,
                imageRight: YonderImages.bruteIcon,
                imageBottom: YonderImages.bruteIcon,
                imageTopLeft: YonderImages.bruteIcon,
                imageTopRight: YonderImages.bruteIcon,
                imageBottomLeft: YonderImages.bruteIcon,
                imageBottomRight: YonderImages.bruteIcon,
                imageInnerTopLeft: YonderImages.bruteIcon,
                imageInnerTopRight: YonderImages.bruteIcon,
                imageInnerBottomLeft: YonderImages.bruteIcon,
                imageInnerBottomRight: YonderImages.bruteIcon
            ) {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 160, height: 40)
            }
        }
    }
}
