//
//  YonderBorder11.swift
//  yonder
//
//  Created by Andre Pham on 27/2/2024.
//

import Foundation
import SwiftUI

struct YonderBorder11<Content: View>: View {
    
    @State private var contentSize: CGSize
    private let content: () -> Content
    
    init(
        @ViewBuilder builder: @escaping () -> Content
    ) {
        self.content = builder
        self.contentSize = CGSize()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content()
                .border(
                    YonderBorder11Presets.inlineColor,
                    width: YonderBorder11Presets.outlineThickness
                )
                .padding(.top, YonderBorder11Presets.outlineThickness)
                .padding(.horizontal, YonderBorder11Presets.outlineThickness)
                .background(YonderBorder11Presets.fillColor)
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                self.contentSize = geo.size
                            }
                    }
                }
            
            YonderBorder11Presets.bottomRiseColor
                .frame(
                    width: self.contentSize.width,
                    height: YonderBorder11Presets.bottomRiseThickness
                )
        }
        .border(
            YonderBorder11Presets.outlineColor,
            width: YonderBorder11Presets.outlineThickness
        )
    }
}

#Preview {
    PreviewContentView {
        VStack {
            YonderBorder11 {
                YonderIcon(
                    image: YonderIcons.useConsumableIcon,
                    sideLength: .large
                )
                .padding(10)
            }
        }
    }
}

