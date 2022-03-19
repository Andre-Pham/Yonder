//
//  CardBuildingBlocks.swift
//  yonder
//
//  Created by Andre Pham on 8/2/2022.
//

import Foundation
import SwiftUI

struct CardBody<Content: View>: View {
    let name: String
    
    private let content: () -> Content
    init(name: String, @ViewBuilder builder: @escaping () -> Content) {
        self.name = name
        self.content = builder
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            YonderText(text: self.name, size: .cardTitle)
                .padding(.top)
            
            content()
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.leading)
        .padding(.trailing)
        .foregroundColor(.Yonder.textMaxContrast)
        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}

struct CardRowView: View {
    var prefix: String? = nil
    var value: Int
    var maxValue: Int? = nil
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image)
            }
            
            HStack(alignment: .lastTextBaseline) {
                if let prefix = self.prefix {
                    YonderTextAndNumeral(format: [.text, .numeral], text: [prefix], numbers: [self.value], size: .cardBody)
                }
                else {
                    YonderNumeral(number: self.value, size: .cardBody)
                }
                
                if let maxValue = maxValue {
                    Spacer()
                    
                    YonderTextAndNumeral(format: [.text, .numeral], text: ["/"], numbers: [maxValue], size: .cardSubscript)
                }
            }
        }
    }
}
