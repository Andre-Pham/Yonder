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
        .padding(.leading)
        .padding(.trailing)
        .foregroundColor(.Yonder.textMaxContrast)
        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}

struct CardRowView: View {
    var value: String
    var maxValue: String = ""
    var image: Image? = nil
    
    var body: some View {
        HStack {
            if let image = self.image {
                YonderIcon(image: image)
            }
            
            if self.maxValue.count > 0 {
                HStack(alignment: .lastTextBaseline) {
                    YonderText(text: self.value, size: .cardBody)
                    
                    Spacer()
                    
                    YonderText(text: "/\(self.maxValue)", size: .cardSubscript)
                }
            }
            else {
                YonderText(text: self.value, size: .cardBody)
            }
        }
    }
}
