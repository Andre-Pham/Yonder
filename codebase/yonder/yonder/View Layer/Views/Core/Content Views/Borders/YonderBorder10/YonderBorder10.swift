//
//  YonderBorder10.swift
//  yonder
//
//  Created by Andre Pham on 27/2/2024.
//

import Foundation
import SwiftUI

struct YonderBorder10<Content: View>: View {
    
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
                    YonderBorder10Presets.inlineColor,
                    width: YonderBorder10Presets.outlineThickness
                )
                .padding(.top, YonderBorder10Presets.outlineThickness)
                .padding(.horizontal, YonderBorder10Presets.outlineThickness)
                .background(YonderBorder10Presets.fillColor)
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .preference(key: BorderSizePreferenceKey.self, value: geo.size)
                    }
                }
                .onPreferenceChange(BorderSizePreferenceKey.self) { newSize in
                    withAnimation(.none) {
                        self.contentSize = newSize
                    }
                }
            
            YonderBorder10Presets.bottomRiseColor
                .frame(
                    width: self.contentSize.width,
                    height: YonderBorder10Presets.bottomRiseThickness
                )
        }
        .border(
            YonderBorder10Presets.outlineColor,
            width: YonderBorder10Presets.outlineThickness
        )
    }
}

#Preview {
    PreviewContentView {
        VStack {
            YonderBorder10 {
                YonderIcon(
                    image: YonderIcons.usePotionIcon,
                    sideLength: .large
                )
                .padding(10)
            }
        }
    }
}
