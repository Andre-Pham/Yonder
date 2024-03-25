//
//  YonderBorder7.swift
//  yonder
//
//  Created by Andre Pham on 26/2/2024.
//

import SwiftUI

struct YonderBorder7<Content: View>: View {
    
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
                .padding(.top, YonderBorder7Presets.outlineThickness)
                .padding(.horizontal, YonderBorder7Presets.outlineThickness)
                .background(YonderBorder7Presets.fillColor)
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
            
            YonderBorder7Presets.bottomRiseColor
                .frame(
                    width: self.contentSize.width,
                    height: YonderBorder7Presets.bottomRiseThickness
                )
        }
        .border(
            YonderBorder7Presets.outlineColor,
            width: YonderBorder7Presets.outlineThickness
        )
    }
}

#Preview {
    PreviewContentView {
        YonderBorder7 {
            Rectangle()
                .fill(.clear)
                .frame(width: 160, height: 100)
        }
    }
}
