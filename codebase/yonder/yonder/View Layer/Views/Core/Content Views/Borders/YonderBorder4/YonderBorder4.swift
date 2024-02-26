//
//  YonderBorder4.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import SwiftUI

struct YonderBorder4<Content: View>: View {
    
    private let content: () -> Content
    
    init(
        @ViewBuilder builder: @escaping () -> Content
    ) {
        self.content = builder
    }
    
    var body: some View {
        content()
            .padding(YonderBorder4Presets.outlineThickness)
            .background(YonderBorder4Presets.fillColor)
            .border(
                YonderBorder4Presets.outlineColor,
                width: YonderBorder4Presets.outlineThickness
            )
    }
}

#Preview {
    PreviewContentView {
        VStack {
            YonderBorder4 {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 160, height: 100)
            }
            
            YonderBorder4 {
                VStack(alignment: .leading) {
                    YonderText(text: "10x Potions", size: .buttonBody)
                    
                    YonderWideButton(text: "Purchase", action: { })
                }
                .padding(8)
            }
        }
    }
}
