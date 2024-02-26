//
//  YonderBorder9.swift
//  yonder
//
//  Created by Andre Pham on 26/2/2024.
//

import Foundation
import SwiftUI

struct YonderBorder9<Content: View>: View {
    
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
                    YonderBorder9Presets.inlineColor,
                    width: YonderBorder9Presets.outlineThickness
                )
                .padding(.top, YonderBorder9Presets.outlineThickness)
                .padding(.horizontal, YonderBorder9Presets.outlineThickness)
                .background(YonderBorder9Presets.fillColor)
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                self.contentSize = geo.size
                            }
                    }
                }
            
            YonderBorder9Presets.bottomRiseColor
                .frame(
                    width: self.contentSize.width,
                    height: YonderBorder9Presets.bottomRiseThickness
                )
        }
        .border(
            YonderBorder9Presets.outlineColor,
            width: YonderBorder9Presets.outlineThickness
        )
    }
}

#Preview {
    PreviewContentView {
        VStack {
            YonderBorder9 {
                YonderIcon(
                    image: YonderIcons.useWeaponIcon,
                    sideLength: .large
                )
                .padding(10)
            }
        }
    }
}
