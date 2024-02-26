//
//  YonderBorder5.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import Foundation
import SwiftUI

struct YonderBorder5<Content: View>: View {
    
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
                    YonderBorder5Presets.inlineColor,
                    width: YonderBorder5Presets.outlineThickness
                )
                .padding(.top, YonderBorder5Presets.outlineThickness)
                .padding(.horizontal, YonderBorder5Presets.outlineThickness)
                .background(YonderBorder5Presets.fillColor)
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                self.contentSize = geo.size
                            }
                    }
                }
            
            YonderBorder5Presets.bottomRiseColor
                .frame(
                    width: self.contentSize.width,
                    height: YonderBorder5Presets.bottomRiseThickness
                )
        }
        .border(
            YonderBorder5Presets.outlineColor,
            width: YonderBorder5Presets.outlineThickness
        )
    }
}

#Preview {
    PreviewContentView {
        VStack {
            YonderBorder5 {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 160, height: 100)
            }
            
            YonderBorder5 {
                YonderText(text: "Your Options", size: .buttonBody)
                    .padding()
            }
            
            YonderBorder5 {
                VStack(alignment: .leading) {
                    YonderText(text: "10x Potions", size: .buttonBody)
                    
                    YonderWideButton(text: "Purchase", action: { })
                }
                .padding(8)
            }
        }
    }
}
