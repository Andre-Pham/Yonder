//
//  YonderBorder8.swift
//  yonder
//
//  Created by Andre Pham on 26/2/2024.
//

import SwiftUI

struct YonderBorder8<Content: View>: View {
    
    private let content: () -> Content
    
    init(
        @ViewBuilder builder: @escaping () -> Content
    ) {
        self.content = builder
    }
    
    var body: some View {
        VStack(spacing: 0) {
            content()
                .background(YonderBorder8Presets.fillColor)
                .border(
                    YonderBorder8Presets.outlineColor,
                    width: YonderBorder8Presets.outlineThickness
                )
        }
    }
}

#Preview {
    PreviewContentView {
        VStack {
            YonderBorder8 {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 160, height: 100)
            }
            
            YonderBorder8 {
                YonderIconNumeralPair(prefix: Strings("currencySymbol").local, image: YonderIcons.goldIcon, numeral: 100, size: .buttonBody)
                    .padding(.horizontal, YonderCoreGraphics.padding*1.5)
                    .padding(.vertical, YonderCoreGraphics.padding)
            }
            
            YonderBorder4 {
                VStack(alignment: .leading) {
                    HStack {
                        YonderText(text: "10x Potions", size: .buttonBody)
                        
                        Spacer()
                        
                        YonderBorder8 {
                            YonderIconNumeralPair(prefix: Strings("currencySymbol").local, image: YonderIcons.goldIcon, numeral: 100, size: .buttonBody)
                                .padding(.horizontal, YonderCoreGraphics.padding*1.5)
                                .padding(.vertical, YonderCoreGraphics.padding)
                        }
                    }
                    
                    YonderWideButton(text: "Purchase", action: { })
                }
                .padding(8)
            }
        }
    }
}
