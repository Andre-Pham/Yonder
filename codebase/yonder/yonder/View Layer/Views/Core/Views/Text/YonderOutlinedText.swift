//
//  YonderOutlinedText.swift
//  yonder
//
//  Created by Andre Pham on 14/5/2022.
//

import SwiftUI

struct YonderOutlinedText: View {
    let text: String
    let size: YonderTextSize
    var color: Color = Color.Yonder.textMaxContrast
    var multilineTextAlignment: TextAlignment = .leading
    var outlineColor: Color
    var width: CGFloat {
        return self.size.value/24
    }
    
    var body: some View {
        ZStack {
            ZStack {
                YonderText(
                    text: self.text,
                    size: self.size,
                    color: self.outlineColor,
                    multilineTextAlignment: self.multilineTextAlignment)
                    .offset(x: width, y: width)
                
                YonderText(
                    text: self.text,
                    size: self.size,
                    color: self.outlineColor,
                    multilineTextAlignment: self.multilineTextAlignment)
                    .offset(x: -width, y: -width)
                
                YonderText(
                    text: self.text,
                    size: self.size,
                    color: self.outlineColor,
                    multilineTextAlignment: self.multilineTextAlignment)
                    .offset(x: -width, y: width)
                
                YonderText(
                    text: self.text,
                    size: self.size,
                    color: self.outlineColor,
                    multilineTextAlignment: self.multilineTextAlignment)
                    .offset(x: width, y: -width)
                
                YonderText(
                    text: self.text,
                    size: self.size,
                    color: self.outlineColor,
                    multilineTextAlignment: self.multilineTextAlignment)
                    .offset(x: -width)
                
                YonderText(
                    text: self.text,
                    size: self.size,
                    color: self.outlineColor,
                    multilineTextAlignment: self.multilineTextAlignment)
                    .offset(x: width)
                
                YonderText(
                    text: self.text,
                    size: self.size,
                    color: self.outlineColor,
                    multilineTextAlignment: self.multilineTextAlignment)
                    .offset(y: -width)
                
                YonderText(
                    text: self.text,
                    size: self.size,
                    color: self.outlineColor,
                    multilineTextAlignment: self.multilineTextAlignment)
                    .offset(y: -width)
            }
            
            YonderText(
                text: self.text,
                size: self.size,
                color: self.color,
                multilineTextAlignment: self.multilineTextAlignment)
        }
    }
}

struct YonderOutlinedText_Previews: PreviewProvider {
    static var previews: some View {
        YonderOutlinedText(text: "Hello World", size: .buttonBody, color: .black, outlineColor: .red)
    }
}
