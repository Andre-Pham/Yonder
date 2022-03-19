//
//  OptionButton.swift
//  yonder
//
//  Created by Andre Pham on 10/12/21.
//

import SwiftUI

struct OptionButton: View {
    let title: String
    let geometry: GeometryProxy
    let image: Image
    var width: CGFloat {
        geometry.size.width/3 - YonderCoreGraphics.padding*4/3
    }
    var height: CGFloat {
        geometry.size.width/3 - YonderCoreGraphics.padding*2
    }
    
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                YonderIcon(image: self.image, sideLength: .large)
                
                YonderText(text: self.title, size: .optionBody)
            }
            .padding(.horizontal)
            .frame(width: self.width, height: self.height)
            .border(Color.Yonder.border, width: YonderCoreGraphics.borderWidth)
        }
    }
}
