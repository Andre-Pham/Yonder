//
//  SurroundingBrackets.swift
//  yonder
//
//  Created by Andre Pham on 25/6/2022.
//

import SwiftUI

struct SurroundingBrackets<Content: View>: View {
    let bracket: String
    let size: YonderTextSize
    let color: Color
    private let content: () -> Content
    
    init(bracket: String, size: YonderTextSize, color: Color = YonderColors.textMaxContrast, @ViewBuilder builder: @escaping () -> Content) {
        self.bracket = bracket
        self.size = size
        self.color = color
        self.content = builder
    }
    
    var body: some View {
        HStack(spacing: 0) {
            YonderText(text: self.bracket, size: self.size, color: self.color)
            
            content()
            
            YonderText(text: self.bracket, size: self.size, color: self.color)
                .scaleEffect(CGSize(width: -1, height: 1))
        }
    }
}

struct SurroundingBrackets_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            YonderColors.backgroundMaxDepth
                .ignoresSafeArea()
            
            SurroundingBrackets(bracket: "[", size: .buttonBody) {
                YonderText(text: "Hello World", size: .buttonBody)
            }
        }
    }
}
