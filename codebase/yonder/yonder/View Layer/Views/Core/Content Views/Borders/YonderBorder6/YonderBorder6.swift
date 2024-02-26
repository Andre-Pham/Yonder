//
//  YonderBorder6.swift
//  yonder
//
//  Created by Andre Pham on 18/2/2024.
//

import Foundation
import SwiftUI

struct YonderBorder6<Content: View>: View {
    
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
                    YonderBorder6Presets.inlineColor,
                    width: YonderBorder6Presets.outlineThickness
                )
                .padding(.top, YonderBorder3Presets.outlineThickness)
                .padding(.horizontal, YonderBorder3Presets.outlineThickness)
                .background(YonderBorder6Presets.fillColor)
                .overlay {
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                self.contentSize = geo.size
                            }
                    }
                }
            
            YonderBorder6Presets.bottomRiseColor
                .frame(
                    width: self.contentSize.width,
                    height: YonderBorder6Presets.bottomRiseThickness
                )
        }
        .border(
            YonderBorder6Presets.outlineColor,
            width: YonderBorder6Presets.outlineThickness
        )
    }
}

#Preview {
    PreviewContentView {
        VStack {
            YonderBorder6 {
                Rectangle()
                    .fill(.clear)
                    .frame(width: 160, height: 100)
            }
            
            YonderBorder6 {
                YonderIconNumeralPair(prefix: Strings("currencySymbol").local, image: YonderIcons.goldIcon, numeral: 100, size: .buttonBody)
                    .padding(.horizontal, YonderCoreGraphics.padding*1.5)
                    .padding(.vertical, YonderCoreGraphics.padding)
            }
            
            YonderBorder4 {
                VStack(alignment: .leading) {
                    HStack {
                        YonderText(text: "10x Potions", size: .buttonBody)
                        
                        Spacer()
                        
                        YonderBorder6 {
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
