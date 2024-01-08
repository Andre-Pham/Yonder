//
//  EightSliceBorder.swift
//  yonder
//
//  Created by Andre Pham on 9/1/2024.
//

import SwiftUI

struct EightSliceBorder<Content: View>: View {
    
    @State private var contentSize: CGSize
    
    let scale: Double
    let imageTop: YonderImage
    let imageLeft: YonderImage
    let imageRight: YonderImage
    let imageBottom: YonderImage
    let imageTopLeft: YonderImage
    let imageTopRight: YonderImage
    let imageBottomLeft: YonderImage
    let imageBottomRight: YonderImage
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
        self.content = builder
        self.contentSize = CGSize()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Top row
            HStack(spacing: 0) {
                self.imageTopLeft.image
                    .resizable()
                    .interpolation(.none)
                    .frame(
                        width: self.imageTopLeft.width*self.scale,
                        height: self.imageTopLeft.height*self.scale
                    )
                
                self.imageTop.image
                    .resizable()
                    .interpolation(.none)
                    .frame(
                        width: self.contentSize.width,
                        height: self.imageTop.height*self.scale
                    )
                
                self.imageTopRight.image
                    .resizable()
                    .interpolation(.none)
                    .frame(
                        width: self.imageTopRight.width*self.scale,
                        height: self.imageTopRight.height*self.scale
                    )
            }
            
            // Middle row
            HStack(spacing: 0) {
                self.imageLeft.image
                    .resizable()
                    .interpolation(.none)
                    .frame(
                        width: self.imageLeft.width*self.scale,
                        height: self.contentSize.height
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
                
                self.imageRight.image
                    .resizable()
                    .interpolation(.none)
                    .frame(
                        width: self.imageRight.width*self.scale,
                        height: self.contentSize.height
                    )
            }
            
            // Bottom row
            HStack(spacing: 0) {
                self.imageBottomLeft.image
                    .resizable()
                    .interpolation(.none)
                    .frame(
                        width: self.imageBottomLeft.width*self.scale,
                        height: self.imageBottomLeft.height*self.scale
                    )
                
                self.imageBottom.image
                    .resizable()
                    .interpolation(.none)
                    .frame(
                        width: self.contentSize.width,
                        height: self.imageBottom.height*self.scale
                    )
                
                self.imageBottomRight.image
                    .resizable()
                    .interpolation(.none)
                    .frame(
                        width: self.imageBottomRight.width*self.scale,
                        height: self.imageBottomRight.height*self.scale
                    )
            }
        }
    }
}

struct EightSliceBorder_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            EightSliceBorder(
                scale: 0.3,
                imageTop: YonderImages.bruteIcon,
                imageLeft: YonderImages.bruteIcon,
                imageRight: YonderImages.bruteIcon,
                imageBottom: YonderImages.bruteIcon,
                imageTopLeft: YonderImages.bruteIcon,
                imageTopRight: YonderImages.bruteIcon,
                imageBottomLeft: YonderImages.bruteIcon,
                imageBottomRight: YonderImages.bruteIcon
            ) {
                Rectangle()
                    .fill(.blue)
                    .frame(width: 120, height: 20)
            }
        }
    }
}
