//
//  OptionView.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct OptionView: View {
    let title: String
    let geometry: GeometryProxy
    
    var body: some View {
        VStack {
            YonderText(text: self.title, size: .buttonBody)
            // Icon would go underneith
        }
        .frame(width: geometry.size.width/3 - YonderCoreGraphics.padding*4/3, height: geometry.size.width/3 - YonderCoreGraphics.padding*2)
        .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
    }
}
