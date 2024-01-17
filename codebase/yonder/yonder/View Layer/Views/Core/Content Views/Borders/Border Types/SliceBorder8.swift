//
//  SliceBorder8.swift
//  yonder
//
//  Created by Andre Pham on 9/1/2024.
//

import SwiftUI

struct SliceBorder8<Content: View>: View {
    
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
            HStack(alignment: .bottom, spacing: 0) {
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
                
                BorderSlice(
                    source: self.imageRight,
                    scale: self.scale,
                    heightOverride: self.contentSize.height
                )
            }
            
            // Bottom row
            HStack(alignment: .top, spacing: 0) {
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

struct SliceBorder8_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContentView {
            SliceBorder8(
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

// TODO: The plan is to make a PressableEightSliceBorder
/*
 struct ParentView: View {
     @State private var isButtonPressed = false

     var body: some View {
         SliceBorder8(isButtonPressed: $isButtonPressed, content: {
             Button("Hello") {
                 print("Hello")
             }
             .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                 self.isButtonPressed = pressing
             }) {
                 // This closure is empty because the action is handled by the pressing parameter
             }
         })
     }
 }

 struct EightSliceBorder<Content: View>: View {
     @Binding var isButtonPressed: Bool
     let content: Content

     var body: some View {
         content
             .border(isButtonPressed ? Color.red : Color.blue, width: 5) // Adjust border based on pressing state
     }

     init(isButtonPressed: Binding<Bool>, @ViewBuilder content: () -> Content) {
         self._isButtonPressed = isButtonPressed
         self.content = content()
     }
 }
*/
