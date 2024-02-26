//
//  YonderBorder3.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import SwiftUI

struct YonderBorder3<Content: View>: View {
    
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
                .padding(.top, YonderBorder3Presets.outlineThickness)
                .padding(.horizontal, YonderBorder3Presets.outlineThickness)
                .background(YonderBorder3Presets.fillColor)
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                self.contentSize = geo.size
                            }
                    }
                }
            
            YonderBorder3Presets.bottomRiseColor
                .frame(
                    width: self.contentSize.width,
                    height: YonderBorder3Presets.bottomRiseThickness
                )
        }
        .border(
            YonderBorder3Presets.outlineColor,
            width: YonderBorder3Presets.outlineThickness
        )
    }
}

#Preview {
    YonderBorder3 {
        Rectangle()
            .fill(.clear)
            .frame(width: 160, height: 100)
    }
}
