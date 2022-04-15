//
//  CardBody.swift
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading)
        .padding(.trailing)
        .foregroundColor(.Yonder.textMaxContrast)
        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}
